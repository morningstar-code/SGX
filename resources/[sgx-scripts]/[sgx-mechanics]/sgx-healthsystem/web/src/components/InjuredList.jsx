import React from 'react';
import ItemContainer from './ItemContainer';
import { InjuredPerson } from './Icons';
import { useData } from 'contexts/DataContext';
import classNames from 'classnames';
import { useLang } from 'contexts/LangContext';

export default function InjuredList() {
    const { injuryList, items } = useData();
    const { lang } = useLang();
    return (
        <ItemContainer
            icon={<InjuredPerson />}
            height="11.3125rem"
            color="#FFFFFF"
            header={lang.injuryListHeader}
            description={lang.injuryListDesc}
            className="overflow-y-auto h-24"
        >
            {Object.keys(injuryList).map((item, key) => (
                <div
                    className={classNames(
                        'h-[2.8125rem] w-full flex items-center',
                        {
                            'mb-2': key !== Object.keys(injuryList).length - 1
                        }
                    )}
                >
                    <div
                        style={{
                            background:
                                'linear-gradient(115.97deg, rgba(255, 156, 156, 0.5) 9.77%, rgba(201, 64, 64, 0.5) 93.68%)'
                        }}
                        className="min-w-[2.8125rem] h-full relative flex items-center justify-center rounded-sm"
                    >
                        <div className="absolute left-0 top-0 w-full h-full border border-white/[0.08] rounded-sm" />
                        <img
                            className="w-[1.625rem] h-[1.625rem] object-cover"
                            src={'./items/' + items[item]?.icon}
                        />
                    </div>

                    <div className="w-full h-[2.375rem] rounded-sm bg-white/[0.06] flex items-center justify-between px-[1.125rem] !pr-2.5">
                        <p className="text-white text-sm font-gr-sb">
                            {items[item]?.label}
                        </p>

                        <div className="w-6 h-6 bg-white/[0.06] rounded-sm flex items-center justify-center text-white/50 text-[.8167rem] font-gr-m text-xs">
                            {injuryList[item] ?? 1}x
                        </div>
                    </div>
                </div>
            ))}
        </ItemContainer>
    );
}
