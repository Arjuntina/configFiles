# from libqtile.command.client import InteractiveCommandClient
# c = InteractiveCommandClient()
# batteryWidget = c.widget['battery']
# batteryWidget.info().update({'text': '20220'})
# batteryWidget.force_update()

import asyncio

async def main():
    print('Hello ...')
    await asyncio.sleep(1)
    print('... World!')

asyncio.run(main())
