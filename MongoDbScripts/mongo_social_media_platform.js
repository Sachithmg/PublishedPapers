/*
Design considerations for No-SQL schema
1. Based on relationship mapping
2. If entities are tightly couple (used frequently with queries) and change often with the parent entity, then embedded. 

Entities merge from normalization model:
	Group 1: 	Users + Fiends + Location (Embed)
	Group 2:  	Albums + Photos + Videos + Locations + Post + Comments (Embed)
	Linked:
				Users will be linked for Friends as Array. Fiends will be attribute of Users 
				User to Album, Post and Comments 
3. Apply Schema version pattern – this is to support iterative approach of development. 
4. Computing Pattern – which can be used to track number of posts and comments so that we can save computational power later. 
*/

// Connect to MongoDB
const conn = new Mongo();

// Access the database
const db = conn.getDB('social_media_platform_dts2113');

print("------------Drop database--------------------- \n");
db.dropDatabase();

// Switch to a different database
db.getSiblingDB('social_media_platform_dts2113');
print("-----------Switch to new database social_media_platform_dts2113---------------- \n");


//Creete Collection for users
print("-----Create Collection for Users and Index-------- \n");
db.createCollection("users");
//Create unique index for email 
db.users.createIndex({"email":1},{unique : true});
//Create Index for search 
db.users.createIndex({"home_town.city": 1});
db.users.createIndex({"lives.city": 1});
db.users.createIndex({"first_name" : 1});

print("-----Insert multiple documents to users-------------- \n");
db.users.insertMany(
[
	{
		"schema" : 1,
		"first_name" : "John",
		"middle_name" : "A.",
		"last_name" : "Doe",
		"email" : "johndoe@socialmedia.com",
		"dob" : ISODate("2000-05-15"),
		"gender" : "M",
		"password" : "password1",
		"home_town" : {
			"city" : "Kandy",
			"state" : "Central Province",
			"country" : "Sri Lanka"
		},
		"lives" : {
			"city" : "Colombo",
			"state" : "Western Province",
			"country" : "Sri Lanka"
		},
		"friends" : []		
	},
	{
		"schema" : 1,
		"first_name" : "Jane",
		"middle_name" : null,
		"last_name" : "Smith",
		"email" : "janesmith@socialmedia.com",
		"dob" : ISODate("1988-09-21"),
		"gender" : "F",
		"password" : "password2",
		"home_town" : {
			"city" : "Colombo",
			"state" : "Western Province",
			"country" : "Sri Lanka"
		},
		"lives" : {
			"city" : "Kandy",
			"state" : "Central Province",
			"country" : "Sri Lanka"
		},
		"friends" : []
	},
	{
		"schema" : 1,
		"first_name" : "David",
		"middle_name" : "C.",
		"last_name" : "Johnson",
		"email" : "davidjohnson@socialmedia.com",
		"dob" : ISODate("1992-02-08"),
		"gender" : "M",
		"password" : "password3",
		"home_town" : {
			"city" : "Galle",
			"state" : "Southern Province",
			"country" : "Sri Lanka"
		},
		"lives" : {
			"city" : "Galle",
			"state" : "Southern Province",
			"country" : "Sri Lanka"
		},
		"friends" : []
	},
	{
		"schema" : 1,
		"first_name" : "Sarah",
		"middle_name" : "E.",
		"last_name" : "Wilson",
		"email" : "sarahwilson@socialmedia.com",
		"dob" : ISODate("1995-11-30"),
		"gender" : "F",
		"password" : "password4",
		"home_town" : {
			"city" : "Nuwara Eliya",
			"state" : "Central Province",
			"country" : "Sri Lanka"
		},
		"lives" : {
			"city" : "Nuwara Eliya",
			"state" : "Central Province",
			"country" : "Sri Lanka"
		},
		"friends" : []
	},
	{
		"schema" : 1,
		"first_name" : "Michael",
		"middle_name" : "R.",
		"last_name" : "Brown",
		"email" : "michaelbrown@socialmedia.com",
		"dob" : ISODate("1987-07-18"),
		"gender" : "M",
		"password" : "password5",
		"home_town" : {
			"city" : "Trincomalee",
			"state" : "Eastern Province",
			"country" : "Sri Lanka"
		},
		"lives" : {
			"city" : "Anuradhapura",
			"state" : "North Central Province",
			"country" : "Sri Lanka"
		},
		"friends" : []
	},
	{
		"schema" : 1,
		"first_name" : "Emily",
		"middle_name" : "M.",
		"last_name" : "Taylor",
		"email" : "emilytaylor@socialmedia.com",
		"dob" : ISODate("1991-04-03"),
		"gender" : "F",
		"password" : "password6",
		"home_town" : {
			"city" : "Jaffna",
			"state" : "Northern Province",
			"country" : "Sri Lanka"
		},
		"lives" : {
			"city" : "Bentota",
			"state" : "Southern Province",
			"country" : "Sri Lanka"
		},
		"friends" : []
	},
	{
		"schema" : 1,
		"first_name" : "Daniel",
		"middle_name" : "J.",
		"last_name" : "Anderson",
		"email" : "danielanderson@socialmedia.com",
		"dob" : ISODate("1989-12-12"),
		"gender" : "M",
		"password" : "password7",
		"home_town" : {
			"city" : "Bentota",
			"state" : "Southern Province",
			"country" : "Sri Lanka"
		},
		"lives" : {
			"city" : "Jaffna",
			"state" : "Northern Province",
			"country" : "Sri Lanka"
		},
		"friends" : []
	},
	{
		"schema" : 1,
		"first_name" : "Olivia",
		"middle_name" : "K.",
		"last_name" : "Miller",
		"email" : "oliviamiller@socialmedia.com",
		"dob" : ISODate("1993-06-25"),
		"gender" : "F",
		"password" : "password8",
		"home_town" : {
			"city" : "Dambulla",
			"state" : "Central Province",
			"country" : "Sri Lanka"
		},
		"lives" : {
			"city" : "Dambulla",
			"state" : "Central Province",
			"country" : "Sri Lanka"
		},
		"friends" : []
	},
	{
		"schema" : 1,
		"first_name" : "Thomas",
		"middle_name" : "L.",
		"last_name" : "Davis",
		"email" : "thomasdavis@socialmedia.com",
		"dob" : ISODate("1994-09-10"),
		"gender" : "M",
		"password" : "password9",
		"home_town" : {
			"city" : "Colombo",
			"state" : "Western Province",
			"country" : "Sri Lanka"
		},
		"lives" : {
			"city" : "Kandy",
			"state" : "Central Province",
			"country" : "Sri Lanka"
		},
		"friends" : []
	},
	{
		"schema" : 1,
		"first_name" : "Sophia",
		"middle_name" : "N.",
		"last_name" : "Wilson",
		"email" : "sophiawilson@socialmedia.com",
		"dob" : ISODate("2005-03-27"),
		"gender" : "F",
		"password" : "password10",
		"home_town" : {
			"city" : "Kandy",
			"state" : "Central Province",
			"country" : "Sri Lanka"
		},
		"lives" : {
			"city" : "Colombo",
			"state" : "Western Province",
			"country" : "Sri Lanka"
		},
		"friends" : []
	}
]
);

print("------------ Print # of Documents in users collection---------- \n");
// Get the count of documents in the collection
var count = db.users.countDocuments();
print(`Number of documents in users collection: ${count}`);

print("-----------Update Friends------------------------------ \n");
/*
Insert Friends is complex task. 
Step involved: 
1.	Find the user who need to be added with friends 
2.	Find the friends _ids 
3.	Add all ids to friends array 
*/

var primaryUser = db.users.find({"email" : "danielanderson@socialmedia.com"},{_id: 1});

var friends = db.users.find({"email" : {$in: ["oliviamiller@socialmedia.com"]}},{_id: 1});


primaryUser.forEach(key => {
	friends.forEach(friend => {
		db.users.updateOne({_id: key._id},{$push:{"friends": friend._id}});
})});

var primaryUser = db.users.find({"email" : "davidjohnson@socialmedia.com"},{_id: 1});

var friends = db.users.find({"email" : {$in: ["sarahwilson@socialmedia.com"]}},{_id: 1});


primaryUser.forEach(key => {
	friends.forEach(friend => {
		db.users.updateOne({_id: key._id},{$push:{"friends": friend._id}});
})});

primaryUser = db.users.find({"email" : "emilytaylor@socialmedia.com"},{_id: 1});

friends = db.users.find({"email" : {$in: ["danielanderson@socialmedia.com"]}},{_id: 1});


primaryUser.forEach(key => {
	friends.forEach(friend => {
		db.users.updateOne({_id: key._id},{$push:{"friends": friend._id}});
})});

primaryUser = db.users.find({"email" : "janesmith@socialmedia.com"},{_id: 1});

friends = db.users.find({"email" : {$in: ["davidjohnson@socialmedia.com"]}},{_id: 1});


primaryUser.forEach(key => {
	friends.forEach(friend => {
		db.users.updateOne({_id: key._id},{$push:{"friends": friend._id}});
})});

primaryUser = db.users.find({"email" : "johndoe@socialmedia.com"},{_id: 1});

friends = db.users.find({"email" : {$in: ["janesmith@socialmedia.com","thomasdavis@socialmedia.com"]}},{_id: 1});


primaryUser.forEach(key => {
	friends.forEach(friend => {
		db.users.updateOne({_id: key._id},{$push:{"friends": friend._id}});
})});

primaryUser = db.users.find({"email" : "michaelbrown@socialmedia.com"},{_id: 1});

friends = db.users.find({"email" : {$in: ["emilytaylor@socialmedia.com"]}},{_id: 1});


primaryUser.forEach(key => {
	friends.forEach(friend => {
		db.users.updateOne({_id: key._id},{$push:{"friends": friend._id}});
})});
		
		
primaryUser = db.users.find({"email" : "oliviamiller@socialmedia.com"},{_id: 1});

friends = db.users.find({"email" : {$in: ["thomasdavis@socialmedia.com"]}},{_id: 1});


primaryUser.forEach(key => {
	friends.forEach(friend => {
		db.users.updateOne({_id: key._id},{$push:{"friends": friend._id}});		
})});
		
primaryUser = db.users.find({"email" : "sarahwilson@socialmedia.com"},{_id: 1});

friends = db.users.find({"email" : {$in: ["michaelbrown@socialmedia.com"]}},{_id: 1});


primaryUser.forEach(key => {
	friends.forEach(friend => {
		db.users.updateOne({_id: key._id},{$push:{"friends": friend._id}});	
})});		

primaryUser = db.users.find({"email" : "sophiawilson@socialmedia.com"},{_id: 1});

friends = db.users.find({"email" : {$in: ["johndoe@socialmedia.com"]}},{_id: 1});


primaryUser.forEach(key => {
	friends.forEach(friend => {
		db.users.updateOne({_id: key._id},{$push:{"friends": friend._id}});	
})});	

primaryUser = db.users.find({"email" : "thomasdavis@socialmedia.com"},{_id: 1});

friends = db.users.find({"email" : {$in: ["sophiawilson@socialmedia.com"]}},{_id: 1});


primaryUser.forEach(key => {
	friends.forEach(friend => {
		db.users.updateOne({_id: key._id},{$push:{"friends": friend._id}});	
})});	

print("-----------List final user documents------------ \n");
print(db.users.find());
print("\n\n\n");


//Creete Collection for Albums
print("-----Create Collection for Albums and Index-------- \n");
db.createCollection("albums");

//Create unique index for email 


print("---------------Insert Documents to Album------------- \n");
/*
Since the users have loaded using insert and update to simulate the scenario of application working, 
album will be loaded only with insert to simulate history load. 
*/
var tmpCurUser = db.users.find({"email" : "johndoe@socialmedia.com"},{_id: 1});
var tmpUser = tmpCurUser.hasNext() ? tmpCurUser.next() : null;
var johndoe = '';
if (tmpUser){
	johndoe = tmpUser._id;
	print(johndoe);
}

tmpCurUser = db.users.find({"email" : "janesmith@socialmedia.com"},{_id: 1});
tmpUser = tmpCurUser.hasNext() ? tmpCurUser.next() : null;
var janesmith = '';
if (tmpUser){
	janesmith = tmpUser._id;
	print(janesmith);
}

tmpCurUser = db.users.find({"email" : "davidjohnson@socialmedia.com"},{_id: 1});
tmpUser = tmpCurUser.hasNext() ? tmpCurUser.next() : null;
var davidjohnson = '';
if (tmpUser){
	davidjohnson = tmpUser._id;
	print(davidjohnson);
}

tmpCurUser = db.users.find({"email" : "sarahwilson@socialmedia.com"},{_id: 1});
tmpUser = tmpCurUser.hasNext() ? tmpCurUser.next() : null;
var sarahwilson = '';
if (tmpUser){
	sarahwilson = tmpUser._id;
	print(sarahwilson);
}

tmpCurUser = db.users.find({"email" : "michaelbrown@socialmedia.com"},{_id: 1});
tmpUser = tmpCurUser.hasNext() ? tmpCurUser.next() : null;
var michaelbrown = '';
if (tmpUser){
	michaelbrown = tmpUser._id;
	print(michaelbrown);
}

tmpCurUser = db.users.find({"email" : "emilytaylor@socialmedia.com"},{_id: 1});
tmpUser = tmpCurUser.hasNext() ? tmpCurUser.next() : null;
var emilytaylor = '';
if (tmpUser){
	emilytaylor = tmpUser._id;
	print(emilytaylor);
}

tmpCurUser = db.users.find({"email" : "danielanderson@socialmedia.com"},{_id: 1});
tmpUser = tmpCurUser.hasNext() ? tmpCurUser.next() : null;
var danielanderson = '';
if (tmpUser){
	danielanderson = tmpUser._id;
	print(danielanderson);
}

tmpCurUser = db.users.find({"email" : "oliviamiller@socialmedia.com"},{_id: 1});
tmpUser = tmpCurUser.hasNext() ? tmpCurUser.next() : null;
var oliviamiller = '';
if (tmpUser){
	oliviamiller = tmpUser._id;
	print(oliviamiller);
}

tmpCurUser = db.users.find({"email" : "thomasdavis@socialmedia.com"},{_id: 1});
tmpUser = tmpCurUser.hasNext() ? tmpCurUser.next() : null;
var thomasdavis = ''
if (tmpUser){
	thomasdavis = tmpUser._id;
	print(thomasdavis);
}

tmpCurUser = db.users.find({"email" : "sophiawilson@socialmedia.com"},{_id: 1});
tmpUser = tmpCurUser.hasNext() ? tmpCurUser.next() : null;
var sophiawilson = '';
if (tmpUser){
	sophiawilson = tmpUser._id;
	print(sophiawilson);
}

print("-----Insert multiple documents to Album-------------- \n");
db.albums.insertMany([
	{
		"schema" : 1,
		"name" : "Summer Vacation",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : johndoe,
		"photos" : [{
			"caption" : "Summer Vacation Photo",
		    "city" : "Kandy",
		    "state" : "Central Province",
		    "country" : "Sri Lanka"
		}],
		"videos" : [],
		"posts" : [{
			"topic" : "Amazing sunset",
		    "post_date" : ISODate("2023-07-10"),
		    "post_owner" : johndoe, 
			"comments" : [
			{"date" : ISODate("2023-07-10"),
		     "text" : "I wish I could be there!",
		     "user" : janesmith},
			{"date" : ISODate("2023-07-10"),
		     "text" : "Beautiful photo!",
		     "user" : johndoe} 
			]
		}]		
	},
	{
		"schema" : 1,
		"name" : "New Year 2023",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : johndoe,
		"photos" : [
			{"caption" : "New Year 2023 Photo"}],
	    "videos" : [],
		"posts" : []
	},
	{
		"schema" : 1,
		"name" : "Family Reunion",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : janesmith,
		"photos" : [{
			"caption" : "Family Reunion Photo",
			"city" : "Colombo",
			"state" : "Western Province",
			"country" : "Sri Lanka"}],
		"videos" : [{
			"caption" : "Family Reunion Video",
			"city" : "Colombo",
			"state" : "Western Province",
			"country" : "Sri Lanka"}],
		"posts" : [{
			"topic" : "Family gathering",
		    "post_date" : ISODate("2023-07-10"),
			"post_owner" : janesmith,
			"comments" : [{
				"date" : ISODate("2023-07-10"),
				"text" : "Great to see everyone together!",
				"user" : davidjohnson},
				{"date" : ISODate("2023-07-10"),
				"text" : "Such a lovely family photo!",
				"user" : sarahwilson}]
			}]
	},
	{
		"schema" : 1,
		"name" : "Hiking Adventures",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : davidjohnson,
		"photos" : [{
			"caption" : "Hiking Adventures Photo",
			"city" : "Galle",
			"state" : "Southern Province",
			"country" : "Sri Lanka"}],
		"videos" : [{
			"caption" : "Hiking Adventures Video",
			"city" : "Galle",
			"state" : "Southern Province",
			"country" : "Sri Lanka"}],
		"posts" : [{
			"topic" : "Exploring nature",
			"post_date" : ISODate("2023-07-10"),
			"post_owner" : davidjohnson,
			"comments" : [{
				"date" : ISODate("2023-07-10"),
				"text" : "Nature at its finest!",
				"user" : emilytaylor},
				{"date" : ISODate("2023-07-10"),
				"text" : "What a breathtaking view!",
				"user" : michaelbrown}]
		}]
	},
	{
		"schema" : 1,
		"name" : "Beach Party",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : sarahwilson,
		"photos" : [{
			"caption" : "Beach Party Photo",
			"city" : "Nuwara Eliya",
			"state" : "Central Province",
			"country" : "Sri Lanka"}],
		"videos" : [{
			"caption" : "Beach Party Video",
			"city" : "Nuwara Eliya",
			"state" : "Central Province",
			"country" : "Sri Lanka"}],
		"posts" : [{
			"topic" : "Fun at the beach",
			"post_date" : ISODate("2023-07-10"),
			"post_owner" : sarahwilson,
			"comments" : [{
				"date" : ISODate("2023-07-10"),
				"text" : "Wish I could join you guys!",
				"user" : danielanderson},
				{"date" : ISODate("2023-07-10"),
				"text" : "Looks like a great time!",
				"user" : oliviamiller}]
		}]
	},
	{
		"schema" : 1,
		"name" : "Road Trip Memories",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : michaelbrown,
		"photos" : [{
			"caption" : "Road Trip Memories Photo",
			"city" : "Trincomalee",
			"state" : "Eastern Province",
			"country" : "Sri Lanka"}],
		"videos" : [{
			"caption" : "Road Trip Memories Video",
			"city" : "Trincomalee",
			"state" : "Eastern Province",
			"country" : "Sri Lanka"}], 
		"posts" : [{
			"topic" : "Road trip memories",
			"post_date" : ISODate("2023-07-10"),
			"post_owner" : michaelbrown,
			"comments" : [{
				"date" : ISODate("2023-07-10"),
				"text" : "Road trips are the best!",
				"user" : sophiawilson},
				{"date" : ISODate("2023-07-10"),
				"text" : "Such fond memories!",
				"user" : thomasdavis}]
		}]
	},
	{
		"schema" : 1,
		"name" : "City Exploration",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : emilytaylor,
		"photos" : [{
			"caption" : "City Exploration Photo",
			"city" : "Gampaha",
			"state" : "Western Province",
			"country" : "Sri Lanka"}],
		"videos" : [{
			"caption" : "City Exploration Video",
			"city" : "Gampaha",
			"state" : "Western Province",
			"country" : "Sri Lanka"}],
		"posts" : [{
			"topic" : "City skyline",
			"post_date" : ISODate("2023-07-10"),
			"post_owner" : emilytaylor,
			"comments" : [{
				"date" : ISODate("2023-07-10"),
				"text" : "I love the city lights!",
				"user" : janesmith},
				{"date" : ISODate("2023-07-10"),
				"text" : "What a stunning cityscape!",
				"user" : johndoe}]
		}]	
	},
	{
		"schema" : 1,
		"name" : "Friends",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : emilytaylor,
		"photos" : [{
			"caption" : "Friends Photo",
			"city" : "Jaffna",
			"state" : "Northern Province",
			"country" : "Sri Lanka"}],
		"videos" : [{
			"caption" : "Friends Video",
			"city" : "Jaffna",
			"state" : "Northern Province",
			"country" : "Sri Lanka"}],
		"posts" : []
	},
	{
		"schema" : 1,
		"name" : "Nature Photography",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : danielanderson,
		"photos" : [{
			"caption" : "Nature Photography Photo",
			"city" : "Bentota",
			"state" : "Southern Province",
			"country" : "Sri Lanka"}],
		"videos" : [{
			"caption" : "Nature Photography Video",
			"city" : "Bentota",
			"state" : "Southern Province",
			"country" : "Sri Lanka"}],
		"posts" : [{
			"topic" : "Artistic expressions",
			"post_date" : ISODate("2023-07-10"),
			"post_owner" : danielanderson,
			"comments" : [{
				"date" : ISODate("2023-07-10"),
				"text" : "Beautiful artwork!",
				"user" : davidjohnson},
				{"date" : ISODate("2023-07-10"),
				"text" : "You're so talented!",
				"user" : sarahwilson}]
		}]

	},
	{
		"schema" : 1,
		"name" : "Festival Highlights",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : oliviamiller,
		"photos" : [{
			"caption" : "Festival Highlights Photo",
			"city" : "Dambulla",
			"state" : "Central Province",
			"country" : "Sri Lanka"}],
		"videos" : [{
			"caption" : "Festival Highlights Video",
			"city" : "Dambulla",
			"state" : "Central Province",
			"country" : "Sri Lanka"}],
		"posts" : [{
			"topic" : "Festival moments",
			"post_date" : ISODate("2023-07-10"),
			"post_owner" : oliviamiller,
			"comments" : [{
				"date" : ISODate("2023-07-10"),
				"text" : "Such a fun event!",
				"user" : emilytaylor},
				{"date" : ISODate("2023-07-10"),
				"text" : "I miss those festive vibes!",
				"user" : michaelbrown}]
		}]
	},
	{
		"schema" : 1,
		"name" : "Artistic Creations",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : thomasdavis,
		"photos" : [],
		"videos" : [{
			"caption" : "Artistic Creations Video",
			"city" : "Colombo",
			"state" : "Western Province",
			"country" : "Sri Lanka"}],
		"posts" : [{
			"topic" : "Creative artwork",
			"post_date" : ISODate("2023-07-10"),
			"post_owner" : thomasdavis
		}]
	},
	{
		"schema" : 1,
		"name" : "Wedding Memories",
		"album_date" : ISODate("2023-07-10"),
		"album_owner" : sophiawilson,
		"photos" : [],
		"videos" : [],
		"posts" : [{
			"topic" : "Wedding bliss",
			"post_date" : ISODate("2023-07-10"),
			"post_owner" : sophiawilson},
			{"topic" : "Wedding",
			"post_date" : ISODate("2023-07-10"),
			"post_owner" : johndoe}]
	}
]
);

print("------------ Print # of Documents in Albums collection---------- \n");
// Get the count of documents in the collection
count = db.albums.countDocuments();
print(`Number of documents in albums collection: ${count}`);

print("-----------List Album documents------------ \n");
print(db.albums.find());
print("\n\n\n");

print('------------------------------********************----------------------------------------- \n');
print('1. Find location-based photos and videos posted \n');

var cur = db.albums.find({$or: [{"videos.city": "Kandy"},{"photos.city": "Kandy"}]});

cur.forEach(object => {
		print(object);	
});
print('------------------------------********************----------------------------------------- \n\n\n');

print('------------------------------********************----------------------------------------- \n');
print('2./ 3. Find location-based photos and videos posted. City starting with \'C\' similar to LIKE or REGEXP pattern match in SQL \n');

 cur = db.albums.find({$or: [{"videos.city": { $regex: /^C/i }},{"photos.city": { $regex: /^C/i }}]});

cur.forEach(object => {
		print(object);	
});
print('------------------------------********************----------------------------------------- \n\n\n');

print('------------------------------********************----------------------------------------- \n');
print('4. Find location-based photos and videos posted. City starting with \'B\'  and \'G\' having 7 letters with REGEXP pattern match \n');

 cur = db.albums.find({$or: [{ $and: [{ "videos.city": { $regex: /^.{7}$/ } }, { "videos.city": { $regex: /^(B|G)/ } }  ] },
{ $and: [{ "photos.city": { $regex: /^.{7}$/ } }, { "photos.city": { $regex: /^(B|G)/ } }  ] }]});

cur.forEach(object => {
		print(object);	
});
print('------------------------------********************----------------------------------------- \n\n\n');


print('------------------------------********************----------------------------------------- \n');
print('5. Find location-based photos and videos posted. City having \'B\'  and \'G\' letters anywhere with REGEXP pattern match \n');

 cur = db.albums.find({$or: [{"videos.city": {  $regex: ".*[BG].*"  }},{"photos.city": {  $regex: ".*[BG].*"  }}]});

cur.forEach(object => {
		print(object);	
});
print('------------------------------********************----------------------------------------- \n\n\n');



print('------------------------------********************----------------------------------------- \n');
print('6. No of comments per album \n');
db.albums.find({}, { _id: 1, "posts.comments": 1 }).forEach(album => {
  const albumId = album._id;
  let commentCount = 0;

  if (album.posts && Array.isArray(album.posts)) {
    album.posts.forEach(post => {
      if (post.comments && Array.isArray(post.comments)) {
        commentCount += post.comments.length;
      }
    });
  }

  print(`Album ID: ${albumId}, Comment Count: ${commentCount}`);
});


print('------------------------------********************----------------------------------------- \n\n\n');


print('------------------------------********************----------------------------------------- \n');
print('7. Find the most common city where users have their home town (19 of SQL) \n');

db.users.aggregate([
  {
    $group: {
      _id: "$home_town.city",
      count: { $sum: 1 }
    }
  },
  {
    $sort: { count: -1 }
  },
  {
    $limit: 1
  }
]).forEach(result => {
  print(`Most Common Hometown City: ${result._id}, Count: ${result.count}`);
});

print('------------------------------********************----------------------------------------- \n\n\n');


print('------------------------------********************----------------------------------------- \n');

print('8. Add photo to the album \n');


db.albums.updateOne(
  { name: "Festival Highlights" },
  { $push: {
    photos: {
      caption: "Another Beach Party Photo",
      city: "Colombo",
      state: "Western Province",
      country: "Sri Lanka"
    }
  }}
);


print('9 . Find the users who have posted the most number of photos (SQL - 20) \n');
const albumCounts = db.albums.find().map(album => ({
  userId: album.album_owner,
  photoCount: album.photos.length
}));

var highestPhotoCount = 0; 
var usersWithHighestPhotoCount = 0
albumCounts.forEach(album => {
	if ( album.photoCount > highestPhotoCount) {
		highestPhotoCount = album.photoCount;
        usersWithHighestPhotoCount = album.userId	}

});


var user =  db.users.find({_id: usersWithHighestPhotoCount});

user.forEach(user => {
  print(`User ID: ${user._id}, Name: ${user.first_name} ${user.last_name},  Total Photos: ${highestPhotoCount} `);
});




print('------------------------------********************----------------------------------------- \n\n\n');


print('------------------------------********************----------------------------------------- \n');
print('10. Find the users who have not posted any photos or videos (SQL - 21) \n');

print('Object before delete \n');


const usersWithNoPhotosOrVideos = db.users.find({
  _id: {
    $nin: db.albums.distinct("album_owner", {
      $or: [
        { "photos": { $exists: true, $not: { $size: 0 } } },
        { "videos": { $exists: true, $not: { $size: 0 } } }
      ]
    })
  }
}).toArray();


print('After delete \n');

print(`Users with no photos or videos:`);
usersWithNoPhotosOrVideos.forEach(user => {
  print(`User ID: ${user._id}, Name: ${user.first_name} ${user.last_name}`);
});


print('------------------------------********************----------------------------------------- \n\n\n');




print('------------------------------********************----------------------------------------- \n');
print('11. Delete the additional photo added \n');

const album = db.albums.find({name: "Festival Highlights" });

album.forEach(album => {
  print(album);
});


db.albums.updateOne(
  { name: "Festival Highlights" },
  { $pull: { photos: { caption: "Another Beach Party Photo" } } }
);


album = db.albums.find({name: "Festival Highlights" });

album.forEach(album => {
  print(album);
});



print('------------------------------********************----------------------------------------- \n\n\n');




print('------------------------------********************----------------------------------------- \n');
print('12. Delete the object itself \n');

db.albums.deleteOne({ name: "Festival Highlights" });



print('------------------------------********************----------------------------------------- \n\n\n');



