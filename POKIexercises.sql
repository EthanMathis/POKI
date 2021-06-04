/*
What grades are stored in the database?  [ 1st - 5th grades ]

	select * from Grade;

What emotions may be associated with a poem?   [ Anger, Fear, Sadness, Joy ]

	select * from Emotion;

How many poems are in the database?		[ 32842 ]

	select count(Poem.Id) as PoemCount from Poem;

Sort authors alphabetically by name. What are the names of the top 76 authors?

	select top 76 Author.Name 
	from Author 
	order by Author.Name;

Starting with the above query, add the grade of each of the authors.

	select top 76 Author.Name,
			  Grade.Name
			  from Author 
			  left join Grade on Grade.Id = Author.GradeId
			  order by Author.Name;

Starting with the above query, add the recorded gender of each of the authors.
	
	select top 76 Author.Name,
			  Gender.Name
			  from Author 
			  left join Gender on Gender.Id = Author.GenderId
			  order by Author.Name;

What is the total number of words in all poems in the database?		[ 374584 ]

	select sum(Poem.WordCount) as TotalWordCount
	from Poem

Which poem has the fewest characters?		[ HI ]

	select Poem.Title
	   from Poem
	   where CharCount = (select min(CharCount) from Poem);

How many authors are in the third grade?		[ 2344 ]

	select count(Author.GradeId) as AuthorCount
	   from Author where Author.GradeId = 3;

How many total authors are in the first through third grades?		[ 1st=623  -  2nd=1437  -  3rd=2344 ]

		select count(Author.GradeId) as AuthorCount,
		   Grade.Id as GradeId
		   from Author 
		   left join Grade on Grade.Id = Author.GradeId
		   where GradeId <= 3
		   group by Grade.Id
		   order by COUNT(Author.GradeId) asc;
	
What is the total number of poems written by fourth graders?		[ 10806 ]

	select count(Poem.Id) as PoemCount
		from Poem
		left join Author on Author.Id = Poem.AuthorId
		where Author.GradeId = 4;

How many poems are there per grade?		[ 1st=886  -  2nd=3160  -  3rd=6636  -  4th=10806  -  5th=11354 ]

	select COUNT(Poem.id) as PoemCount,
		   Grade.Id
		   from Poem 
		   left join Author on Poem.AuthorId = Author.Id
		   left join Grade on Author.GradeId = Grade.Id
		   group by Grade.Id
		   order by Grade.Id;


How many authors are in each grade? (Order your results by grade starting with 1st Grade)		[ 1st=623  -  2nd=1437  -  3rd=2344  -  4th=3288  -  5th=3464 ]
	
	select COUNT(Author.Id) as AuthorCount,
		   Grade.Name
		   from Author
		   left join Grade on Author.GradeId = Grade.Id
		   group by Grade.Name
		   order by COUNT(Author.Id);

What is the title of the poem that has the most words?		[ The Misterious Black ]

	select Poem.Title, 
		   Poem.WordCount
		   from Poem 
		   where WordCount = (select max(WordCount) from poem);

Which author(s) have the most poems? (Remember authors can have the same name.)		[ TOP 3: jessica(118)	emily(115)	 emily(98) ]

		select top 3 Author.Id as AuthorId,
				     Author.Name as AuthorName,
				     COUNT(Author.Id) as PoemCount
				     from poem
				     left join Author on Author.Id = Poem.AuthorId
				     group by Author.Id, Author.Name
				     order by COUNT(Author.Id) desc;

How many poems have an emotion of sadness?		[ 14570 ]

	select COUNT(PoemEmotion.EmotionId) as EmoCount
		   from PoemEmotion
		   left join Emotion on Emotion.Id = PoemEmotion.EmotionId
		   where Emotion.Name = 'sadness';

How many poems are not associated with any emotion?		[ 3368 ]

	select COUNT(Poem.Id) as PoemCount
		   from Poem
		   left join PoemEmotion on Poem.Id = PoemEmotion.PoemId
		   where PoemEmotion.PoemId is null
		   order by COUNT(Poem.Id);

Which emotion is associated with the least number of poems?		[ Anger : 11105 ]

	select top 1 COUNT(PoemEmotion.PoemId) as PoemCount,
				 Emotion.Name
			     from PoemEmotion
			     left join Emotion on Emotion.Id = PoemEmotion.EmotionId
				 group by Emotion.Name
				 order by COUNT(PoemId);

Which grade has the largest number of poems with an emotion of joy?		[ 5th Grade  -  8928 ]

	select top 1 Grade.Name,
			   COUNT(Poem.Id) as JoyfulPoemCount
			   from Grade
			   left join Author on Author.GradeId = Grade.Id
			   left join Poem on Poem.AuthorId = Author.Id
			   left join PoemEmotion on Poem.Id = PoemEmotion.PoemId
			   where PoemEmotion.EmotionId = 4
			   group by Grade.Name
			   order by COUNT(Poem.Id) desc

Which gender has the least number of poems with an emotion of fear?			[ Ambiguous  -  1435 ]

	select top 1 Gender.Name,
				 COUNT(Author.GenderId) as FearPoemCount
				 from Poem
				 left join Author on Author.Id = Poem.AuthorId
				 left join Gender on Gender.Id = Author.GenderId
				 left join PoemEmotion on PoemEmotion.PoemId = Poem.Id
				 left join Emotion on Emotion.Id = PoemEmotion.EmotionId
				 where Emotion.Name = 'fear'
				 group by Gender.Name
				 order by COUNT(Author.GenderId) asc

*/