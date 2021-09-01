const likeToggle = () => {
  const likes = document.querySelectorAll(".fa-thumbs-up")
  likes.forEach((like) => {
    like.addEventListener('click', () => {
      like.classList.toggle("mystyle")
    })
  })
}

export { likeToggle }
