import React from 'react';
import { useDraggable } from '@dnd-kit/core';

export function Draggable(props) {
    const { attributes, listeners, setNodeRef } = useDraggable({
        id: props.id
    });

    return (
        <button
            className="w-full relative"
            ref={setNodeRef}
            {...listeners}
            {...attributes}
        >
            {props.children}
        </button>
    );
}
