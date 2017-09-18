import * as React from 'react';
import { api } from '../lib/pipeline_deals/api'
import * as data from '../lib/pipeline_deals/data/index'
import { Bar as BarChart } from 'react-chartjs-2';
import * as numeral from 'numeral';
import * as Color from 'chartjs-color'
import * as Spinner from 'react-spinner';

const defaultColor = '#006abb';

type StageStats<T = number> = {
  [stageName:string]: T;
};

interface ChartsState {
  loading: boolean;
  data: ChartData;
}

interface ChartDataOptions {
  scales?: {
    yAxes?: Array<{
      ticks?: {
        callback: (value: number, index: number, values: number[]) => number | string
      }
    }>,
  },
  tooltips?: {
    callbacks?: {
      label: (tooltipItem: ChartTooltipItem) => number | string;
    }
  }
}

interface ChartData {
  labels: string[];
  datasets: ChartDataset[];
  options?: ChartDataOptions;
}

interface ChartDataset {
  label: string;
  data: number[] | string[]; 
  backgroundColor: string[];
  borderColor: string[];
  borderWidth: number;
}

interface ChartTooltipItem {
  datasetIndex: number;
  index: number;
  x: number;
  xLabel: string;
  y: number;
  yLabel: number;
}

interface DealStageMap {
  [stage:string]: number; // Maps deal stage => completion
}

export class StagesChart extends React.PureComponent<{}, ChartsState> {
  private dealStages: DealStageMap = {};
  
  constructor() {
    super();
    this.yAxisTickFormatter = this.yAxisTickFormatter.bind(this);
    this.tooltipValueFormatter = this.tooltipValueFormatter.bind(this);
    this.sortDealStage = this.sortDealStage.bind(this);
    this.reduceDeals = this.reduceDeals.bind(this);
    this.state = {
      loading: false,
      data: {
        labels: [],
        datasets: [],
      }
    }
  }

  componentWillMount() {
    this.getDealStats().then(data => {
      this.setState({data})
    }).catch(err => {
      console.error(err);
      alert('Unknown error occurred fetching data.')
    })
  }

  render() {
    if (this.state.loading) {
      return <Spinner/>
    }

    return (
      <div>
        <BarChart data={this.state.data} options={this.chartOptions()}/>
      </div>
    )
  }

  private getDealStats() {
    this.setState({loading: true})
    this.dealStages = {}
    return api.deal.list({}).then(resp => {
      this.setState({loading: false})
      let deals = resp.deals.reduce<StageStats>(this.reduceDeals, {})
      for (var stage in deals) {
        deals[stage] = deals[stage] / 100
      }
      return this.statsToChartData(deals);
    }).catch(err => {
      this.setState({loading: false})        
      throw err
    })
  }

  // getCurrencyFormatString returns a format string suitable for formatting a dollar.
  // Ideally, the app fetches the company settings during the mounting process and 
  // this function does a lookup on a setting to determine which currency to return
  // a format string for. For now, this function assumes all currencies are USD.
  private getCurrencyFormatString() {
    return '$0,0.00';   
  }

  private statsToChartData(data: StageStats<number>): ChartData {
    let labels: string[] = [];
    for (var stage in data) {
      labels.push(stage)
    }
    labels = this.sortLabels(labels);
    let values = labels.map(stage => data[stage]);
    const datasets = [this.datasetFromValues(labels, values)]
    return {
      labels, 
      datasets,
      options: this.chartOptions(),
    }
  }

  private sortLabels(labels: string[]): string[] {
    return labels.sort(this.sortDealStage);
  }

  private sortDealStage(a: string, b: string): number {
    if (this.dealStages[a] < this.dealStages[b]) {
      return -1;
    } else if (this.dealStages[a] > this.dealStages[b]) {
      return 1;
    } else {
      return 0;
    }
  }


  private chartOptions() {
    return {
      scales: {
        yAxes: [
          {
            ticks: {
              callback: this.yAxisTickFormatter,
            }
          }
        ],
      },
      tooltips: {
        callbacks: {
          label: this.tooltipValueFormatter,
        }
      }
    }
  }

  private yAxisTickFormatter(value: number, index: number, values: number[]): string {
    return numeral(value).format(this.getCurrencyFormatString());
  }

  private tooltipValueFormatter(item: ChartTooltipItem): string {
    return numeral(item.yLabel).format(this.getCurrencyFormatString());
  }

  private datasetFromValues(stages: string[], data: number[]): ChartDataset {
    return {
      label: 'Stage value',
      data,
      backgroundColor: stages.map(this.getStageBackgroundColor),
      borderColor: stages.map(this.getStageBorderColor),
      borderWidth: 1,
    }
  }

  private getStageBackgroundColor(stage: string, index: number): string {
    return Color(defaultColor).alpha(0.6).rgbString()
  }
  
  private getStageBorderColor(stage: string, index: number): string {
    return Color(defaultColor).alpha(0.8).rgbString()
  }

  private reduceDeals(prev: StageStats, curr: data.Deal): StageStats {
    const name = curr.deal_stage.name;
    const percent = curr.deal_stage.percent;
    const value = curr.value_in_cents;
    this.dealStages[name] = percent;
    if (!prev[name]) {
      prev[name] = 0;
    }
    prev[name] += value
    return prev
  }
}