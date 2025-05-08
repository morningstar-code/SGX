import React from 'react';

export default function ItemContainer({
    children,
    icon,
    header = 'Healing items you have',
    color = '#FF4D4D',
    description = 'Lorem ipsum dolor sit amet consectetur. Massa enim lobortis risus arcu. Sed enim sollicitudin ac convallis.',
    height = '19.1875rem',
    className = ''
}) {
    return (
        <div
            style={{ height }}
            className="w-[25.8125rem] relative border border-white/20"
        >
            <div className="absolute -left-0.5 -top-0.5 bg-white w-[.1875rem] h-[.1875rem]" />
            <div className="absolute -right-0.5 -top-0.5 bg-white w-[.1875rem] h-[.1875rem]" />
            <div className="absolute -left-0.5 -bottom-0.5 bg-white w-[.1875rem] h-[.1875rem]" />
            <div className="absolute -right-0.5 -bottom-0.5 bg-white w-[.1875rem] h-[.1875rem]" />

            <div className="w-full h-[4.6875rem] bg-white/10 py-2 px-[.9375rem]">
                <div className="flex items-center gap-x-[.3125rem]">
                    {icon}
                    <p style={{ color }} className="font-gr-sb">
                        {header}
                    </p>
                </div>
                <p className="font-gr-r text-white/[0.58] text-xs">
                    {description}
                </p>
            </div>

            <div className={className + ' p-[1.125rem]'}>{children}</div>
        </div>
    );
}
