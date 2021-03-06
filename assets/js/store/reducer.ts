import { combineReducers } from 'redux';
import { SIGNOUT } from '../pages/Auth/ducks/action-types';
import app from '../pages/App/reducer';
import auth from '../pages/Auth/ducks/reducer';

const combinedReducer = combineReducers({
  app,
  auth,
});

const rootReducer = (state: any, action: any) => {
  if (action.type === SIGNOUT) {
    state = undefined;
  }
  return combinedReducer(state, action);
};

export default rootReducer;
