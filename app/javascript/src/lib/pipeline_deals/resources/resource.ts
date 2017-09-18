// The Resource class provides shared functionality across all API Resource
// classes such as prefixing the resource path with the API URL.
export class Resource {
  
    // API_URL should be configured at runtime by the consumer if their DEALS
    static API_URL: string = '';

    // prefix takes a path and prefixes the API_URL to form a fully qualified
    // resource URL.
    static prefix(path: string): string {
        return this.API_URL + path;
    }
}