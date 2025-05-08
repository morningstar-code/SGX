/** @type {import('tailwindcss').Config} */
export default {
    content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
    theme: {
        extend: {
            fontFamily: {
                'gr-l': 'Gilroy-Light',
                'gr-r': 'Gilroy-Regular',
                'gr-m': 'Gilroy-Medium',
                'gr-sb': 'Gilroy-SemiBold',
                'gr-b': 'Gilroy-Bold',
                af: 'Agency FB'
            }
        }
    },
    plugins: []
};
