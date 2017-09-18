import { DealResource as deal } from './resources/deal';

// API is a namespace for all of the resources that can be 
// be retrieved from the API. Since our server acts as a
// a proxy to the PipelineDeals API, this code should
// be packaged for easier maintenance & distribution.
export const api = {
    deal
}