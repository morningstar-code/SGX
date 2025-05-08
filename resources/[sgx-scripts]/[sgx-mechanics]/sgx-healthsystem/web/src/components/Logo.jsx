import React from 'react';
import logo from 'assets/logo.png';
import { useData } from 'contexts/DataContext';
export default function Logo() {
    const { serverName, serverNameDesc } = useData();
    return (
        <div className="flex gap-x-[1.0625rem]">
            <div
                style={{
                    background:
                        'linear-gradient(180deg, rgba(255, 77, 77, 0) 0%, rgba(255, 77, 77, 0.58) 99%)'
                }}
                className="w-[5.625rem] h-[5.625rem] relative border border-[#FF4D4D]"
            >
                <div className="absolute -left-[.1875rem] -top-[.1875rem] w-[.4375rem] h-[.4375rem] bg-white" />
                <div className="absolute -right-[.1875rem] -top-[.1875rem] w-[.4375rem] h-[.4375rem] bg-white" />
                <div className="absolute -left-[.1875rem] -bottom-[.1875rem] w-[.4375rem] h-[.4375rem] bg-white" />
                <div className="absolute -right-[.1875rem] -bottom-[.1875rem] w-[.4375rem] h-[.4375rem] bg-white" />
                <img
                    className="w-[5.6959rem] h-[5.6959rem] object-cover scale-125"
                    src={logo}
                />
            </div>
            <div>
                <p
                    style={{
                        background:
                            'linear-gradient(253deg, #FF7676 17.32%, #FF4D4D 76.4%)',
                        backgroundClip: 'text',
                        WebkitBackgroundClip: 'text',
                        WebkitTextFillColor: 'transparent'
                    }}
                    className="text-[3.0093rem] font-af font-bold leading-[85%] mt-1.5"
                >
                    {serverName}
                </p>
                <p className="text-[1.9761rem] font-af font-bold text-white">
                    {serverNameDesc}
                </p>
            </div>
        </div>
    );
}
