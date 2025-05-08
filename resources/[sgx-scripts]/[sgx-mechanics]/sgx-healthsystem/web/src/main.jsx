import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App.jsx';
import './index.css';
import LangProvider from 'contexts/LangContext.jsx';
import DataProvider from 'contexts/DataContext.jsx';

ReactDOM.createRoot(document.getElementById('root')).render(
    <LangProvider>
        <DataProvider>
            <App />
        </DataProvider>
    </LangProvider>
);
