View the live version at https://healthy-forager.herokuapp.com

# ℹ️ About

This repository showcases our capstone project for the 9-week Web Development coding bootcamp at Le Wagon Munich Batch #489. We worked in a team of 4 and spent 10 days building this web application.

Forager is an app that shows you healthy products in your local grocery stores. The user searches their location and is able to see all grocery stores near them on a map and a list of products in those stores with a nutriscore associated with each one. The user can then search a type of product, for example cereal, and refine their search with desired nutriscores. They can then click on a product to see detailed nutritional information or add it to their grocery list or favorites list.

# 📚 Stack

- Ruby
- Ruby on Rails
- HTML
- CSS
- JavaScript

# 💪 How It Works

At the moment, only two stores are available in Munich, Germany. This is because we did not want to purchase a Google Maps API key.
Four products are preloaded in the seeds file: joghurt, kase, protein bar, and muesli. The product names are scraped from the two grocery store webpages and then looked up in the [Open Food Facts database](https://world.openfoodfacts.org) using their [Ruby gem](https://github.com/openfoodfacts/openfoodfacts-ruby) to retrieve the nutritional facts and ingredients.

The search operation is implemented with [pg_search](https://rubygems.org/gems/pg_search/versions/1.0.5).

The map is implemented using [mapbox](https://www.mapbox.com/).

Ajax is used to dynamically change the icons (e.g. when click basket icon, changes to check).

[Devise](https://github.com/heartcombo/devise) is used to handle user accounts.

[Pundit](https://github.com/varvet/pundit) is used to handle authorization.

We used [Figma](https://www.figma.com/files/recent) to design the layout of our app.

# 👍 Show Your Support
Give this repository a ⭐ if you liked it or it helped you!
