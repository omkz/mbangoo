// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import PhotoswipeController from "./photoswipe_controller"
application.register("photoswipe", PhotoswipeController)

import StripeController from "./stripe_controller"
application.register("stripe", StripeController)

import VariantSelectionController from "./variant_selection_controller"
application.register("variant-selection", VariantSelectionController)
