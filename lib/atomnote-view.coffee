module.exports =
class AtomnoteView
  constructor: (serializedState, notebooks) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('atomnote')
    #
    # # Create message element
    # message = document.createElement('div')
    # message.textContent = notebooks
    # message.classList.add('message')
    # @element.appendChild(message)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  addElement: (notebooks) =>
    message = document.createElement('div')
    message.textContent = notebooks
    message.classList.add('message')
    message.onclick = console.log(notebooks)
    @element.appendChild(message)
