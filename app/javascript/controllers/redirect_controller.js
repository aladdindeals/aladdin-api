import {Controller} from "stimulus";
import {Turbo} from "@hotwired/turbo-rails";

export default class extends Controller {
    formRedirect(event) {
        const redirectPath = this.element.dataset.redirect;

        if (event.detail.success) {
            Turbo.visit(redirectPath);
        }
    }
}