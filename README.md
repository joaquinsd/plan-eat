# PlanEat
PlanEat is a fantastic platform where users can get a hand to fight the daily stress of thinking what to eat. With PlanEat you can:
* Browse cooking recipes
* Plan weekly menus with your favorite recipes
* Buy your grocieries for the planned menu. 

The best of all is that you can do it all in a single place!

PlanEat is a super basic clone of [ComoQuiero](https://www.comoquiero.net), and is being developed as my final project of the Bootcamp 'Fullstack Developer - Ruby on Rails'. 
The Kanban Board with the User Stroies can be found [here](https://bit.ly/3fA4nQ1).
The deployed version of this App can be found at [Planeat.cl](https://planeat.cl), [Planeat.xyz](https://planeat.xyz) or at [Heroku](https://planeat-cl.herokuapp.com/)
## Used Versions
ruby: `2.6.6` \
rails: `5.2.6`

## Deployment
Deployment of this platform can be achieved pretty easily. First you need the versions of ruby and rails mentioned above and also a postgres server.

### Clone Repository
```bash
git clone https://github.com/joaquinsd/plan-eat
```
### Installing Dependencies
For the app to run smoothly you should install its dependencies
```bash
cd planeat
bundle install
yarn install
```
### Run migrations
First make sure your postgres server is running, then run the migrations.
```bash
rails db:migrate
```
**Optionally** you could run the included `seed` to populate the database with fake test data
```bash
rails db:seed
```
### Running the server
After that you are ready to go and run the server locally
```bash
rails server
```
Now you can visit your cloned app on this [link](https://localhost:3000)