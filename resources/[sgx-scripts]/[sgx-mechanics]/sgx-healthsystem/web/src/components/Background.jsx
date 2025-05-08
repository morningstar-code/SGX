import React from 'react';
import Heartbeat from 'assets/heartbeat.png';
export default function Background() {
    return (
        <div className="absolute left-0 top-0 w-full h-full overflow-hidden">
            <div
                style={{
                    background:
                        'radial-gradient(6.43% 18% at 0% -1.48%, rgba(255, 46, 46, 0.2) 0%, rgba(255, 46, 46, 0) 100%), radial-gradient(22.76% 63.71% at 0% -1.48%, rgba(255, 75, 75, 0.2) 0%, rgba(255, 75, 75, 0) 100%) /* warning: gradient uses a rotation that is not supported by CSS and may not behave as expected */, radial-gradient(30.99% 55.09% at 2.6% -4.77%, #0B0404 0%, rgba(11, 4, 4, 0) 100%) /* warning: gradient uses a rotation that is not supported by CSS and may not behave as expected */, radial-gradient(56.77% 610.33% at -2.08% 73.47%, #0B0404 0%, rgba(11, 4, 4, 0) 100%) /* warning: gradient uses a rotation that is not supported by CSS and may not behave as expected */, radial-gradient(45.98% 494.28% at 114.3% 90.56%, #0B0404 0%, rgba(11, 4, 4, 0) 100%)'
                }}
                className="absolute left-0 top-0 w-full h-full"
            />
            <img
                src={Heartbeat}
                style={{ transform: 'rotate(56.904deg)' }}
                className="absolute -left-40 -bottom-20 w-[33.0995rem] h-[23.3877rem] object-cover opacity-[0.02] pointer-events-none"
            />
        </div>
    );
}
