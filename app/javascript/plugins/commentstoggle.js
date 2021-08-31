const commentsToggle = (video) => {
  x = document.getElementById(`comment-${video}`);
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
};


export { commentsToggle };
