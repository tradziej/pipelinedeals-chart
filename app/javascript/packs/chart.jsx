import React from 'react'
import ReactDOM from 'react-dom'
import {
  BarChart, Bar, CartesianGrid, XAxis, YAxis, Tooltip, Legend
} from 'recharts'

class Chart extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      isLoading: true,
      deals: [],
      error: null
    }
  }

  componentDidMount() {
    this.fetchDeals()
  }

  render() {
    const { isLoading, deals, error } = this.state

    if (isLoading) {
      return <p>Loading...</p>
    }

    if (error) {
      return <p>Error: {error.message}</p>
    }

    return (
      <BarChart width={800} height={350} data={deals}>
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="name" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Bar dataKey="total" fill="#1076ba" />
      </BarChart>
    )
  }

  fetchDeals() {
    fetch('/deals/index.json')
    .then(response => {
      if (!response.ok) {
        throw Error(response.statusText)
      }
      return response.json()
    }).then(data => this.setState({ deals: data, isLoading: false }))
    .catch(error => this.setState({ error, isLoading: false }))
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Chart />,
    document.body.appendChild(document.createElement('div')),
  )
})
