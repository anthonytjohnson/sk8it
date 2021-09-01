const commentsToggle = () => {
  let commentButtons = document.querySelectorAll(".comment-list")
  commentButtons.forEach((commentButton) => {
    const videoId = commentButton.dataset.videoId;
    commentButton.addEventListener('click', () => {
      let x = document.getElementById(`comments-${videoId}`);
      if (x.style.display === "none") {
        x.style.display = "block";
      } else {
        x.style.display = "none";
      }
    })
  })

};


export { commentsToggle };
