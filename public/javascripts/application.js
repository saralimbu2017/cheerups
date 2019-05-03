
  var commentBtn =  document.querySelectorAll('.btn-comment');
  var commentDiv = document.querySelector('.comment-Div');
  var toogleCommentDiv = function() {
    commentDiv.style.display = "block";
  }
  commentBtn.addEventListener('click',toogleCommentDiv);


 
  // var commentBtns =  document.querySelectorAll('.btn-comment');
  // var commentDiv = document.querySelectorAll('.comment-Div');
  // var toogleCommentDiv = function() {
  //   commentDiv.style.display = "block";
  // }
  // commentBtns.forEach(function(commentBtn){
  //   commentBtn.addEventListener('click',toogleCommentDiv);
  // });
  // commentBtns.addEventListener('click',toogleCommentDiv);
