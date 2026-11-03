# Instagram Database & SQL Analysis

A database design and SQL case study inspired by Instagram. The project models core social-platform activity and answers analytical questions about users, posts, engagement, and hashtags.

## Data model

The schema contains seven related tables:

- **Users** — account information
- **Photos** — posts shared by users
- **Comments** — comments on photos
- **Likes** — user likes on photos
- **Follows** — follower relationships
- **Tags** — hashtags
- **Photo Tags** — association between photos and hashtags

The tables are connected using primary and foreign keys.

![Instagram database ER diagram](https://github.com/sumidhakp123/Instagram-Clone/assets/69155879/67c69e54-87fd-49ee-b624-6eaa0c1deda2)

## Analysis questions

The SQL exercises explore questions such as:

- Who are the five oldest users?
- Which weekday has the most registrations?
- Which users have never posted a photo?
- Which photo received the most likes?
- How many photos does the average user post?
- How do users rank by post count?
- Which hashtags are used most often?
- Which users have liked every photo?
- Which users have never commented?
- What share of users have never commented or have commented?

These questions are framed as product, engagement, and account-quality KPIs.

## Getting started

1. Clone or download this repository.
2. Open the SQL files in a database client compatible with the scripts.
3. Create the database and tables, then load the supplied data (if included).
4. Run the queries to explore the questions listed above.

Check the SQL files for the specific database dialect and setup order.

## Skills demonstrated

Relational database design · primary and foreign keys · SQL joins · aggregation · subqueries · engagement analytics

## Author

[Sumidha Kumari Prasad](https://github.com/sumidhakp123)
