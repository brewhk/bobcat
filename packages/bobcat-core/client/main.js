import React from 'react';
import { Meteor } from 'meteor/meteor';
import { render } from 'react-dom';

import '../lib/main.js';

Meteor.startup(() => {
  render(<h1>Hello World!</h1>, document.getElementById('render-target'));
});