import { createContext, useContext, useState } from 'react';
import { useNuiEvent } from '../hooks/useNuiEvent';

const DataContext = createContext();
export const useData = () => useContext(DataContext);

export default function DataProvider({ children }) {
    const [data, setData] = useState({
        serverName: 'SGXCore',
        serverNameDesc: 'HEALTH-SYSTEM',
        items: {},
        inventoryItems: {},
        injuryList: {},
        healthStatus: {},
        positions: {}
    });

    useNuiEvent('setData', val => setData(prev => ({ ...prev, ...val })));
    useNuiEvent('updatePosition', data => {
        setData(prev => ({
            ...prev,
            positions: { ...prev.positions, [data.key]: data.position }
        }));
    });

    return (
        <DataContext.Provider value={{ ...data }}>
            {children}
        </DataContext.Provider>
    );
}
