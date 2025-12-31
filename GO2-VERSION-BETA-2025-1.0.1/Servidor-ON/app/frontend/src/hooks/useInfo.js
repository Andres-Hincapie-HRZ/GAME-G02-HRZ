import { useContext } from 'react'
import Context from '../context/InfoContextProvider'

export default function useInfo() {
    const { onlinePlayers, patch, coordinates } = useContext(Context)

    return {
        onlinePlayers,
        patch,
        coordinates
    }
} 