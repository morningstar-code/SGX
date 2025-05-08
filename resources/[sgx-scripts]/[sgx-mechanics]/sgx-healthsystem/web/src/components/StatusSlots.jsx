import React from 'react';
import { Line, SquarePlus } from './Icons';
import { useData } from 'contexts/DataContext';
import { useLang } from 'contexts/LangContext';
import classNames from 'classnames';
import { Droppable } from './Droppable';

export default function StatusSlots() {
    const { positions } = useData();
    return (
        <>
            {Object.keys(positions)?.map(bone => {
                const isLeft = bone.charAt(0) == 'r' || bone == 'head';
                return (
                    <div
                        dir={isLeft ? 'ltr' : 'rtl'}
                        style={{
                            left:
                                (isLeft
                                    ? positions[bone]?.x - 4.5
                                    : positions[bone]?.x + 4.5) + '%',
                            top: positions[bone]?.y - 8 + '%',
                            transform: `translate(-${positions[bone]?.x}%, -${positions[bone]?.y}%)`
                        }}
                        className="h-[6.2138rem] absolute flex items-center"
                    >
                        <Slot type={bone} />
                        <Line
                            rotate={
                                (bone.charAt(0) == 'l' && bone !== 'head') ||
                                bone == 'body'
                            }
                            className={'absolute -bottom-6'}
                        />
                    </div>
                );
            })}
        </>
    );
}

const Slot = ({ type = 'lArm' }) => {
    const { lang } = useLang();
    const { healthStatus } = useData();
    const value = healthStatus[type] ?? 100;
    const isRed = (healthStatus[type] ?? 100) <= 50;
    return (
        <div className=" h-[3.0047rem] relative flex items-center gap-x-[.6875rem]">
            <Droppable id={type}>
                <div
                    style={{
                        border: `0.572px solid ${
                            isRed ? '#FF4D4D' : '#4DFF94'
                        }`,
                        background: isRed
                            ? 'linear-gradient(180deg, rgba(255, 77, 77, 0.00) 0%, rgba(255, 77, 77, 0.58) 99%)'
                            : 'linear-gradient(180deg, rgba(77, 255, 148, 0.00) 0%, rgba(77, 255, 148, 0.58) 99%)'
                    }}
                    className="w-[3.0047rem] h-full relative flex items-center justify-center"
                >
                    <div className="absolute -left-0.5 -top-0.5 bg-white w-[.1875rem] h-[.1875rem]" />
                    <div className="absolute -right-0.5 -top-0.5 bg-white w-[.1875rem] h-[.1875rem]" />
                    <div className="absolute -left-0.5 -bottom-0.5 bg-white w-[.1875rem] h-[.1875rem]" />
                    <div className="absolute -right-0.5 -bottom-0.5 bg-white w-[.1875rem] h-[.1875rem]" />

                    <SquarePlus isRed={isRed} />
                </div>
            </Droppable>

            <div>
                <p className="whitespace-nowrap text-white font-gr-sb leading-[.5rem]">
                    {lang[type]}
                </p>
                <span className="text-xs text-white/50 font-gr-r">
                    {lang.health};{' '}
                    <span
                        className={classNames('text-[#4DFF94]', {
                            '!text-[#FF4D4D]': isRed
                        })}
                    >
                        {value}%
                    </span>
                </span>
            </div>
        </div>
    );
};
