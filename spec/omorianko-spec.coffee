Omorianko = require '../lib/omorianko'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Omorianko", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('omorianko')

  describe "when the omorianko:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.omorianko')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'omorianko:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.omorianko')).toExist()

        omoriankoElement = workspaceElement.querySelector('.omorianko')
        expect(omoriankoElement).toExist()

        omoriankoPanel = atom.workspace.panelForItem(omoriankoElement)
        expect(omoriankoPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'omorianko:toggle'
        expect(omoriankoPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.omorianko')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'omorianko:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        omoriankoElement = workspaceElement.querySelector('.omorianko')
        expect(omoriankoElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'omorianko:toggle'
        expect(omoriankoElement).not.toBeVisible()
