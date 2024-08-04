import { Controller } from "@hotwired/stimulus";
import PhotoSwipeLightbox from "photoswipe/lightbox";

// Connects to data-controller="photoswipe"
export default class extends Controller {
  connect() {
    this.lightbox = usePhotoSwipe(this);
  }
}

function usePhotoSwipe(controller) {
  const lightbox = new PhotoSwipeLightbox({
    gallery: controller.element,
    children: "a",
    pswpModule: () => import("photoswipe"),
  });
  lightbox.init();
}
