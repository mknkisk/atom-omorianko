Omorianko = require '../lib/omorianko'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Omorianko", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('atom-omorianko')

    waitsForPromise ->
      activationPromise
    waitsForPromise ->
      atom.workspace.open("README.md")

  describe "when the omorianko activated", ->
    it "add 'omorianko' class to workspace", ->
      expect(workspaceElement.classList.contains('omorianko')).toEqual(true)

  describe "when the omorianko:toggle event is triggered", ->
    it "toggle omorianko off class to workspace", ->
      waitsFor ->
        textEditorView = atom.views.getView(atom.workspace.getTextEditors()[0])
        atom.commands.dispatch textEditorView, 'atom-omorianko:toggle'
      runs ->
        expect(workspaceElement.classList.contains('omorianko')).toEqual(false)

    it "toggle omorianko off class to workspace", ->
      waitsFor ->
        textEditorView = atom.views.getView(atom.workspace.getTextEditors()[0])
        atom.commands.dispatch textEditorView, 'atom-omorianko:toggle'
      waitsFor ->
        textEditorView = atom.views.getView(atom.workspace.getTextEditors()[0])
        atom.commands.dispatch textEditorView, 'atom-omorianko:toggle'
      runs ->
        expect(workspaceElement.classList.contains('omorianko')).toEqual(true)
