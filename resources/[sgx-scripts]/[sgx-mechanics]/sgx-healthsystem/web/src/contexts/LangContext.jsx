import { createContext, useContext, useState } from 'react';
import { useNuiEvent } from '../hooks/useNuiEvent';

const LangContext = createContext();
export const useLang = () => useContext(LangContext);

export default function LangProvider({ children }) {
    const [lang, setLang] = useState({});

    useNuiEvent('setLang', setLang);

    return (
        <LangContext.Provider value={{ lang }}>{children}</LangContext.Provider>
    );
}
