import { useState, useEffect } from 'react';

export default function Nutrition() {
  const [water, setWater] = useState(() => parseInt(localStorage.getItem('waterCount') || '0'));
  const [seeds, setSeeds] = useState(() => JSON.parse(localStorage.getItem('seedLog') || '[]'));
  const [fruitEaten, setFruitEaten] = useState(() => localStorage.getItem('fruitEaten') === 'true');

  useEffect(() => localStorage.setItem('waterCount', water), [water]);
  useEffect(() => localStorage.setItem('seedLog', JSON.stringify(seeds)), [seeds]);
  useEffect(() => localStorage.setItem('fruitEaten', fruitEaten), [fruitEaten]);

  const toggleSeed = (seed) => {
    setSeeds(prev => prev.includes(seed) ? prev.filter(s => s !== seed) : [...prev, seed]);
  };

  const snoozeWater = () => {
    alert("Water reminder snoozed for 30 minutes! Stay hydrated, gorgeous. 💧");
  };

  const seedList = [
    { id: 'sesame', icon: '🖤', name: 'Black Sesame' },
    { id: 'pumpkin', icon: '🎃', name: 'Pumpkin Seeds' },
    { id: 'sunflower', icon: '🌻', name: 'Sunflower Seeds' },
    { id: 'chia', icon: '🌾', name: 'Chia/Flax' }
  ];

  return (
    <div className="tab-pane active">
      <div className="header">
        <h1>Nutrition & Habits</h1>
        <p>Fuel your body with powerful whole foods and deep intention. ✨</p>
      </div>

      {!fruitEaten && (
        <div className="fruit-banner">
          <div className="fruit-banner-content">
            <span className="icon">🍎</span>
            <div>
              <h4>Daily Fruit Check</h4>
              <p>Have you had fresh fruit today?</p>
            </div>
          </div>
          <button className="fruit-btn" onClick={() => setFruitEaten(true)}>
            Yes, I ate fruit!
          </button>
        </div>
      )}

      <div className="card">
        <h3 className="card-title">💧 Mindful Hydration</h3>
        <div className="water-tracker">
          <div className="water-display">
            {water} <span>/ 8 Glasses</span>
          </div>
          <div className="water-actions">
            <button className="btn-primary" onClick={() => setWater(w => Math.min(w + 1, 8))}>
              ＋ Drink Glass
            </button>
            <button className="btn-secondary" onClick={snoozeWater}>
              🕒 Snooze
            </button>
          </div>
        </div>
      </div>

      <div className="card">
        <h3 className="card-title">🌻 My Seed Journal</h3>
        <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)', marginBottom: '1rem' }}>
          Tap each seed icon below to stamp your daily journal entry.
        </p>
        <div className="tap-grid">
          {seedList.map(seed => (
            <div 
              key={seed.id} 
              className={`stamp-btn ${seeds.includes(seed.id) ? 'active' : ''}`}
              onClick={() => toggleSeed(seed.id)}
            >
              <span className="emoji">{seed.icon}</span>
              <span className="label">{seed.name}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
