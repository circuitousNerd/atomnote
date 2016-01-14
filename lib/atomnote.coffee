AtomnoteView = require './atomnote-view'
{CompositeDisposable} = require 'atom'
Evernote = require('evernote').Evernote

module.exports = Atomnote =
  atomnoteView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->

    #TODO pull this from config file instead of hard coding.
    authToken = ''

    client = new Evernote.Client({token: authToken, sandbox: true})
    #debug statement
    console.log(client)

    noteStore = client.getNoteStore()

    notebooks = noteStore.listNotebooks((err, notebooks) ->
        # @atomnoteView = new AtomnoteView(state.atomnoteViewState)
        # @modalPanel = atom.workspace.addModalPanel(item: @atomnoteView.getElement(), visible: false)
        #
        # # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
        # @subscriptions = new CompositeDisposable
        #
        # # Register command that toggles this view
        # @subscriptions.add atom.commands.add 'atom-workspace', 'atomnote:toggle': => @toggle()
        @atomnoteView = new AtomnoteView(state.atomnoteViewState)
        #@atomnoteView.addElement(notebooks)
        @rightPanel = atom.workspace.addRightPanel(item: @atomnoteView.getElement(), visible:true)
        console.log 'Found ' + notebooks.length + ' notebooks:'
        for i of notebooks
            @atomnoteView.addElement(notebooks[i].name)
        return
        )

    console.log('break')



    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atomnote:connect': => @connect()

  deactivate: ->
    @rightPanel.destroy()
    @subscriptions.dispose()
    @atomnoteView.destroy()

  serialize: ->
    atomnoteViewState: @atomnoteView.serialize()

  # toggle: ->
  #   console.log 'Atomnote was toggled!'
  #
  #   if @modalPanel.isVisible()
  #     @modalPanel.hide()
  #   else
  #     @modalPanel.show()

  connect: ->
      console.log 'Connecting to evernote'

    #   if @rightPanel.isVisible()
    #       @rightPanel.hide()
    #   else
    #       @rightPanel.show()
