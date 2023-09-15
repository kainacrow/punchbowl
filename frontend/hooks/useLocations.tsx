import {useEffect, useState} from "react";

export type Location = {
  slug: string;
  name: string;
  id: number;
};

export const useLocations = () => {
  const [locations, setLocations] = useState<Location[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [isError, setIsError] = useState<boolean>(false);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(`${process.env.NEXT_PUBLIC_API_BASE}/api/locations`);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const data = await response.json();

        const locationsData = data.map((item: any) => ({
          slug: item.location_id,
          name: item.name,
          id: item.id,
        }));

        setLocations(locationsData);
        setIsLoading(false);
      } catch (error) {
        setIsError(true);
        setIsLoading(false);
      }
    };

    fetchData();
  }, []);

  return {
    locations,
    isLoading,
    isError,
  };
};

export const useLocation: (slug: string) => Location | null = (slug) => {
  const { locations } = useLocations();

  return locations ? locations.find((location) => location.slug === slug) : null;
};