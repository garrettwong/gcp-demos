using System;

namespace GCPFunctionsX.Utilities
{
    public class TimeMachine
    {
        /// <summary>
        /// Gets the time right now formatted as a long date string
        /// </summary>
        /// <returns></returns>
        public string Now()
        {
            return DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss tt");
        }
    }
}