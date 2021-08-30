const initDropdown = () => {
  const icon = document.querySelector(".dropbtn");
  const dropdownContent = document.getElementById("myDropdown");
  if (icon != null) {
    icon.addEventListener("click", () => {
      dropdownContent.classList.toggle("show");
    })
  }
}

// // Close the dropdown menu if the user clicks outside of it
// window.onclick = function (event) {
//   if (!event.target.matches('.dropbtn')) {
//     var dropdowns = document.getElementsByClassName("dropdown-content");
//     var i;
//     for (i = 0; i < dropdowns.length; i++) {
//       var openDropdown = dropdowns[i];
//       if (openDropdown.classList.contains('show')) {
//         openDropdown.classList.remove('show');
//       }
//     }
//   }
// }

export { initDropdown };
