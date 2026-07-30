import { useState } from 'react';
import DailyRoutines from './components/DailyRoutines';
import Nutrition from './components/Nutrition';
import CycleTracker from './components/CycleTracker';
import GutHealth from './components/GutHealth';
import './index.css';

export default function App() {
  const [activeTab, setActiveTab] = useState('routines');

  const renderTab = () => {
    switch(activeTab) {
      case 'routines': return <DailyRoutines />;
      case 'nutrition': return <Nutrition />;
      case 'cycle': return <CycleTracker />;
      case 'gut': return <GutHealth />;
      default: return <DailyRoutines />;
    }
  };

  return (
    <div className="app-container">
      <div className="content-area">
        {renderTab()}
      </div>

      <nav className="bottom-nav">
        <button 
          className={`nav-item ${activeTab === 'routines' ? 'active' : ''}`}
          onClick={() => setActiveTab('routines')}
        >
          <span className="icon">📝</span>
          <span>Routines</span>
        </button>
        <button 
          className={`nav-item ${activeTab === 'nutrition' ? 'active' : ''}`}
          onClick={() => setActiveTab('nutrition')}
        >
          <span className="icon">🥗</span>
          <span>Nutrition</span>
        </button>
        <button 
          className={`nav-item ${activeTab === 'cycle' ? 'active' : ''}`}
          onClick={() => setActiveTab('cycle')}
        >
          <span className="icon">🩸</span>
          <span>Cycle</span>
        </button>
        <button 
          className={`nav-item ${activeTab === 'gut' ? 'active' : ''}`}
          onClick={() => setActiveTab('gut')}
        >
          <span className="icon">🦠</span>
          <span>Gut</span>
        </button>
      </nav>
    </div>
  );
}
