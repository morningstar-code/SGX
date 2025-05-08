import React from 'react';
import ItemContainer from './ItemContainer';
import { Arm, Body, Foot, Head, Health, Leg } from './Icons';
import { useData } from 'contexts/DataContext';
import classNames from 'classnames';
import { useLang } from 'contexts/LangContext';

const partIcons = {
    lArm: <Arm />,
    rArm: <Arm rotate={true} />,
    head: <Head />,
    body: <Body />,
    lLeg: <Leg />,
    rLeg: <Leg rotate={true} />
};
export default function HealthStatus() {
    const { lang } = useLang();
    const { healthStatus } = useData();
    return (
        <ItemContainer
            icon={<Health />}
            height="18.5625rem"
            color="#4DFF94"
            header={lang.healthStatusHeader}
            description={lang.healthStatusDesc}
            className="grid grid-cols-3 gap-2.5"
        >
            {Object.keys(partIcons).map(part => (
                <div className="w-full h-[5.4375rem] relative rounded-sm border border-white/[0.06] bg-white/[0.05] p-2 flex flex-col justify-between items-center">
                    <div
                        style={{
                            background:
                                healthStatus[part] > 50
                                    ? 'rgba(77, 255, 148, 0.07)'
                                    : 'rgba(255, 101, 101, 0.07)',
                            height: (healthStatus[part] ?? 100) + '%'
                        }}
                        className="absolute left-0 bottom-0 w-full"
                    />
                    <p className="text-center text-xs font-gr-sb text-white">
                        {lang[part] ?? 'Unknown'}
                    </p>
                    {partIcons[part] ?? <Arm />}
                    <span className="text-center text-[.625rem] font-gr-r text-white/50">
                        {lang.health};{' '}
                        <span
                            className={classNames('text-[#4DFF94]', {
                                '!text-[#FF6565]':
                                    (healthStatus[part] ?? 100) <= 50
                            })}
                        >
                            {healthStatus[part] ?? 100}%
                        </span>
                    </span>
                </div>
            ))}
        </ItemContainer>
    );
}
