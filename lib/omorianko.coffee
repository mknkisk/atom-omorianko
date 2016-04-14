OmoriankoView = require './omorianko-view'
{CompositeDisposable} = require 'atom'

module.exports = Omorianko =
  omoriankoView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @omoriankoView = new OmoriankoView(state.omoriankoViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @omoriankoView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'omorianko:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @omoriankoView.destroy()

  serialize: ->
    omoriankoViewState: @omoriankoView.serialize()

  toggle: ->
    console.log 'Omorianko was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
