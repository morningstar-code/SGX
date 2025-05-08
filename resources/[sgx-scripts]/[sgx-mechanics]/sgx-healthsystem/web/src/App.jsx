import { useState } from 'react';
import { useNuiEvent } from './hooks/useNuiEvent';
import Logo from 'components/Logo';
import InventoryItems, { Item } from 'components/InventoryItems';
import InjuredList from 'components/InjuredList';
import HealthStatus from 'components/HealthStatus';
import Background from 'components/Background';
import Human from 'components/Human';
import StatusSlots from 'components/StatusSlots';
import { fetchNui } from 'utils/fetchNui';
import { useEffect } from 'react';
import { DndContext, DragOverlay } from '@dnd-kit/core';

function App() {
    const [isDragging, setIsDragging] = useState(null);
    const [display, setDisplay] = useState(false);
    useNuiEvent('HandleDisplay', setDisplay);

    const keydown = e => {
        if (e.key == 'Escape') fetchNui('close');
    };

    useEffect(() => {
        window.addEventListener('keydown', keydown);

        return () => window.removeEventListener('keydown', keydown);
    }, []);
    return (
        <div className="w-full h-screen m-0 overflow-hidden">
            {display && (
                <DndContext
                    onDragStart={e => {
                        setIsDragging(e.active.id);
                    }}
                    onDragEnd={e => {
                        if (e.over)
                            fetchNui('healBone', {
                                bone: e.over.id,
                                item: isDragging
                            });
                        setIsDragging(null);
                    }}
                >
                    <Background />
                    <div className="w-full h-full px-[3.875rem] py-[3.125rem] relative z-10 flex flex-col gap-y-[2.1875rem]">
                        <Logo />
                        <InventoryItems isDragging={isDragging} />
                        <InjuredList />
                        <HealthStatus />
                    </div>

                    <StatusSlots />
                    <Human />

                    <DragOverlay>
                        {isDragging && <Item item={isDragging} />}
                    </DragOverlay>
                </DndContext>
            )}
        </div>
    );
}

export default App;
