_ = require 'underscore-plus'
{$$, WorkspaceView} = require 'atom'
RubyTestView = require '../lib/ruby-test-view'
TestRunner = require '../lib/test-runner'

describe "RubyTestView", ->
  beforeEach ->
    atom.workspaceView = new WorkspaceView()

  describe "::testFile", ->
    it "instantiates TestRunner, and calls ::run on it", ->
      spyOn(TestRunner.prototype, 'initialize').andCallThrough()
      spyOn(TestRunner.prototype, 'run').andCallThrough()
      spyOn(TestRunner.prototype, 'command').andReturn 'fooTestCommand'

      @view = new RubyTestView()
      spyOn(@view, 'setTestInfo').andCallThrough()
      @view.testFile()
      expect(TestRunner.prototype.initialize).toHaveBeenCalledWith(@view.testRunnerParams())
      expect(TestRunner.prototype.run).toHaveBeenCalled()
      expect(@view.setTestInfo).toHaveBeenCalled()

  describe "::testSingle", ->
    it "intantiates TestRunner and calls ::run on it with specific arguments", ->
      spyOn(TestRunner.prototype, 'initialize').andCallThrough()
      spyOn(TestRunner.prototype, 'run').andCallThrough()
      spyOn(TestRunner.prototype, 'command').andReturn 'fooTestCommand'
      @view = new RubyTestView()
      @view.testSingle()
      params = _.extend({}, @view.testRunnerParams(), {testScope: "single"})
      expect(TestRunner.prototype.initialize).toHaveBeenCalledWith(params)
      expect(TestRunner.prototype.run).toHaveBeenCalled()

  describe "::write", ->
    it "appends content to results element", ->
      @view = new RubyTestView()
      @view.write("foo")
      expect(@view.results.text()).toBe "foo"
