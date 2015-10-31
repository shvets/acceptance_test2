var env = require('./support/env.js');

describe('angularjs homepage todo list', function() {
  it('should add a todo', function() {
    browser.get(env.webappUrl());

    element(by.model('todoList.todoText')).sendKeys('write first protractor test');
    element(by.css('[value="add"]')).click();

    var todoList = element.all(by.repeater('todo in todoList.todos'));
    expect(todoList.count()).toEqual(2);

    expect(todoList.get(1).getText()).toEqual('build an angular app');

    // You wrote your first test, cross it off the list
    todoList.get(1).element(by.css('input')).click();
    var completedAmount = element.all(by.css('.done-true'));
    expect(completedAmount.count()).toEqual(2);
  });
});