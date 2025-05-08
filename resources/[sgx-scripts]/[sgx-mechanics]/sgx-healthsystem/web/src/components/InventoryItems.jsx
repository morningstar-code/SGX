import React from 'react';
import ItemContainer from './ItemContainer';
import { Hearth } from './Icons';
import { useData } from 'contexts/DataContext';
import classNames from 'classnames';
import { Draggable } from './Draggable';
import { useLang } from 'contexts/LangContext';

export default function InventoryItems({ isDragging }) {
    const { inventoryItems } = useData();
    const { lang } = useLang();
    return (
        <ItemContainer
            icon={<Hearth />}
            header={lang.inventoryItemsHeader}
            description={lang.inventoryItemsDesc}
            className="overflow-y-auto overflow-x-hidden h-56"
        >
            {Object.keys(inventoryItems).map((item, key) => (
                <Draggable id={item}>
                    {isDragging !== item && <Item id={key} item={item} />}
                </Draggable>
            ))}
        </ItemContainer>
    );
}

export const Item = ({ id, item }) => {
    const { inventoryItems, items } = useData();
    return (
        <div
            className={classNames('h-[3.625rem] w-full flex items-center', {
                'mb-2': id !== Object.keys(inventoryItems).length - 1
            })}
        >
            <div
                style={{
                    background:
                        'linear-gradient(116deg, rgba(255, 255, 255, 0.50) 9.77%, rgba(153, 153, 153, 0.50) 93.68%)'
                }}
                className="min-w-[3.625rem] h-full relative flex items-center justify-center rounded-sm"
            >
                <div className="absolute left-0 top-0 w-full h-full border border-white/[0.08] rounded-sm" />
                <img
                    className="w-[2.375rem] h-[2.375rem] object-cover"
                    src={'./items/' + items[item]?.icon}
                />
            </div>

            <div className="w-full h-[3.25rem] rounded-sm bg-white/[0.06] flex items-center justify-between px-[1.125rem] !pr-2.5">
                <div>
                    <p className="text-white text-sm font-gr-sb !text-start">
                        {items[item]?.label}
                    </p>
                    <p className="text-white/[0.57] text-xs font-gr-sb !text-start">
                        {items[item]?.description}
                    </p>
                </div>

                <div className="w-8 h-8 bg-white/[0.06] rounded-sm flex items-center justify-center text-white/50 text-[.8167rem] font-gr-m">
                    {inventoryItems[item] ?? 1}x
                </div>
            </div>
        </div>
    );
};
