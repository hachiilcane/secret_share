# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $(".inline-thumbnail").draggable({
    revert: "invalid"
    helper: "clone"
    opacity: 0.5
    cursorAt: {left: 0, top: 0}
  })
  $(".thumbnail-item").tooltip()
  $(".basket-in-list").droppable({
    hoverClass: "basket-in-list-hover"
    accept: ".inline-thumbnail"
    drop: (event, ui) ->
      thumbnailElement = ui.draggable.get(0)
      photo_id = parseInt(thumbnailElement.id.match(/\d+/)[0])
      basket_id = parseInt(this.id.match(/\d+/)[0])
      $.post("/pickings", { basket_id: basket_id, photo_id: photo_id}, (data) ->
        alert("Pushed the photo into the basket!")
      )
  })
