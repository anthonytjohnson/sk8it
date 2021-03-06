import Swal from "sweetalert2";
import Rails from '@rails/ujs';


const initSweetAlert = () => {
  if (document.getElementById("spot-div")) {
    if (document.querySelector("#check-in-form")) {
      Swal.fire({
        title: "Do you want to check in to this spot?",
        confirmButtonText: `Yes`,
        showDenyButton: true,
        denyButtonText: `No`,
      }).then((result) => {
        if (result.isConfirmed) {
          const form = document.querySelector("#check-in-form");
          Rails.fire(form, 'submit');
        }
      })
    }
  }
}

export { initSweetAlert };
