# Create All required file and folder
cd $1
cd src
# Inside src
mkdir redux
mkdir saga
mkdir http

cd redux
# Inside redux
mkdir actions
mkdir reducers
touch store.js
cd actions
# Inside actions
touch client-admin.js
touch index.js
cd ..
# Inside redux
cd reducers
# Inside reducers
touch index.js
touch modules.js
cd ..
# Inside redux
cd ..
# Inside src
cd saga
# Inside saga
touch client-admin-saga.js
touch root-saga.js
cd ..
# Inside src
cd http
# Inside http
touch client-admin.js

# Filling http folder content
# Inside http folder
echo 'import axios from "axios"
export const getClientAdminDetails = async () => {
    let data = await axios.get("https://newsapi.org/v2/everything?q=tesla&from=2023-01-22&sortBy=publishedAt&apiKey=fb6f90e95cca448fbb29f560dcd78ec6")
    return data;
}' >> client-admin.js

cd ..
# Inside src
cd redux
# Inside redux
# Filling store.js
echo 'import { applyMiddleware, createStore } from "redux";
import { rootReducer } from "./reducers";
import { createBrowserHistory } from "history";
import createSagaMiddleware from "redux-saga";
import { routerMiddleware } from "connected-react-router";
import { composeWithDevTools } from "redux-devtools-extension";
import { rootSaga } from "../saga/root-saga";

export const history = createBrowserHistory();
const sagaMiddleware = createSagaMiddleware();
const middlewares = [ sagaMiddleware, routerMiddleware(history) ];
const middlewareEnhancer = applyMiddleware(...middlewares);

export const store =  createStore(
  rootReducer,
  composeWithDevTools(middlewareEnhancer)
);  

sagaMiddleware.run(rootSaga);' >> store.js
cd actions
# Inside actions
# Filling client-admin.js
echo 'export const ClientAdminType = {
    GET_CLIENT_ADMIN_DATA: "GET_CLIENT_ADMIN_DATA",
    SET_CLIENT_ADMIN_DATA: "SET_CLIENT_ADMIN_DATA",
  }
  
  export const getClientAdminData = (data) => 
  ({
    type: ClientAdminType.GET_CLIENT_ADMIN_DATA,
    payload: data,
  });
  
  export const setClientAdminData = (data) => 
  ({
    type: ClientAdminType.SET_CLIENT_ADMIN_DATA,
    payload: data,
  });' >> client-admin.js
# Filling index.js
echo 'export * from "./client-admin";' >> index.js
cd ..
# Inside redux
cd reducers
# Inside reducers
# Filling index.js
echo 'import { combineReducers } from "redux";
import { modulesReducer } from "./modules";


export const rootReducer = combineReducers({
  "MODULES": modulesReducer,
});' >> index.js
# Filling modules.js
echo 'import { ClientAdminType } from "../actions"

export const modulesState = {
  clientAdminData: null,
}

export const modulesReducer = (state = modulesState, action) => {
  switch(action.type) {
    case ClientAdminType.SET_CLIENT_ADMIN_DATA:
      return {
        ...state,
        clientAdminData: action.payload,
      };
    default: return state;
  }
};' >> modules.js
cd ..
# Inside redux
cd ..
# Inside src
cd saga
# Inside saga
# Filling client-admin-saga.js
echo 'import { call, put, takeLatest } from "redux-saga/effects";
import { getClientAdminDetails } from "../http/client-admin";
import {
  ClientAdminType, 
  setClientAdminData,
} from "../redux/actions";

function* workerClientAdminSaga({ payload }) {
  try {
    const clientAdminDetails = yield call(
      getClientAdminDetails,
    );
    yield put(setClientAdminData(clientAdminDetails));
  } catch (err) {
    console.log(err);
  }
};

export function* clientAdminSaga() {
  yield takeLatest(
    ClientAdminType.GET_CLIENT_ADMIN_DATA,
    workerClientAdminSaga
  );
};' >> client-admin-saga.js
# Filling root-saga.js
echo 'import { all, fork } from "redux-saga/effects";
import { clientAdminSaga } from "./client-admin-saga";

export function* rootSaga() {
    yield all([
        fork(clientAdminSaga)
    ]);
}' >> root-saga.js
cd ..
cd ..
# installing required packages
npm i react-redux redux-saga