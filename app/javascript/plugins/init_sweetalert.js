import Swal from "sweetalert2";
import Rails from '@rails/ujs';


const initSweetAlert = () => {
  if (document.querySelector("#check-in-form")) {
    const spotName = document.querySelector("#spot-name").innerText
    Swal.fire({
      title: `Do you want to check in to ${spotName}?`,
      confirmButtonText: `Yes`,
      showDenyButton: true,
      denyButtonText: `No`,
    }).then((result) => {
      if (result.isConfirmed) {
        const form = document.querySelector("#check-in-form");
        Rails.fire(form, 'submit');
      } else {
        console.log("nada");
      }
    })
  }
}

export { initSweetAlert };
