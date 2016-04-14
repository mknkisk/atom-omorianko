{CompositeDisposable} = require 'atom'

module.exports = Omorianko =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-omorianko:toggle': => @toggle()
    atom.views.getView(atom.workspace).classList.add("omorianko")

    atomHome = process.env.ATOM_HOME
    style = document.createElement('style')
    style.textContent = ".omorianko .item-views /deep/ .scroll-view::after {
      background-image: url(\"" + atomHome + "/packages/atom-omorianko/assets/images/anko_01a.png\");
    }"

    atom.views.getView(atom.workspace).appendChild(style)

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  toggle: ->
    atom.views.getView(atom.workspace).classList.toggle("omorianko")
