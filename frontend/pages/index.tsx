import {useContext, useEffect, useMemo} from "react";
import FavoriteButton from "../components/FavoriteButton";
import { LocationHeading } from "../components/LocationHeading";
import { SessionContext } from "../components/SessionProvider";
import { CurrentWeather } from "../components/CurrentWeather";
import { useLocation } from "../hooks/useLocations";
import { useUserFavorites } from "../hooks/useFavorites";
import { useWeather } from "../hooks/useWeather";

const DEFAULT_LOCATION_SLUG = "new_york";

export default function Home() {
  const { setLocationSlug, locationSlug } = useContext(SessionContext);
  const { name } = useLocation(locationSlug) ?? {};
  const { weather } = useWeather(locationSlug);
  const { favorites } = useUserFavorites();

  const isFavorite = useMemo(() => {
    return favorites?.some((favorite) => favorite.location_id === DEFAULT_LOCATION_SLUG);
  }, [favorites, DEFAULT_LOCATION_SLUG])

  useEffect(() => {
    setLocationSlug(DEFAULT_LOCATION_SLUG);
  }, []);

  return (
    <div className="space-y-4">
      <LocationHeading name={name} />
      <CurrentWeather weather={weather} />
      <FavoriteButton isFavorite={isFavorite} locationId={DEFAULT_LOCATION_SLUG} />
    </div>
  );
}
