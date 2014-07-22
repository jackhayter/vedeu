----------------------------------------------------------------------
By class
----------------------------------------------------------------------

Application
  Input
  Output
  Process
  Terminal

ClearInterface

Collection

Colour
  Esc

Command

CommandRepository
  Command
  Repository

Composition
  InterfaceCollection

Compositor
  Composition

Configuration

Coordinate
  Esc
  Terminal

Esc
  Translator

EventRepository

Exit
  EventRepository

HashParser
  TextAdaptor

Input
  EventRepository
  Queue
  Terminal

Interface
  ClearInterface
  Coordinate
  LineCollection
  Presentation
  Queue
  RenderInterface
  Style
  Terminal

InterfaceCollection
  InterfaceRepository

InterfaceRepository
  Interface
  Repository

JSONParser

Launcher
  Application
  Configuration

Line
  Presentation
  StreamCollection
  Style

LineCollection
  Collection
  Line

Menu

Output
  InterfaceRepository
  Terminal

Parser
  Compositor
  HashParser
  JSONParser

Presentation
  Colour

Process
  CommandRepository
  Parser
  Queue

Queue

RenderInterface
  ClearInterface

Repository
  Storage

Storage

Stream
  Presentation
  Style

StreamCollection
  Collection
  Stream

Style
  Esc

Template

Terminal
  Esc
  Application

TextAdaptor

Translator

Wordwrap


----------------------------------------------------------------------
Orphans
----------------------------------------------------------------------

Template - orphaned
Wordwrap - orphaned
Menu     - orphaned

Exit     - orphaned
  EventRepository


----------------------------------------------------------------------
Grouped
----------------------------------------------------------------------

Launcher
  Application
    Input
      EventRepository
      Queue
      Terminal
        Esc
          Translator
    Output
      InterfaceRepository
        Interface
          ClearInterface
          Coordinate
            Esc
              Translator
            Terminal
              Esc
                Translator
          LineCollection
            Collection
            Line
              Presentation
                Colour
                  Esc
                    Translator
              StreamCollection
                Collection
                Stream
                  Presentation
                    Colour
                      Esc
                        Translator
                  Style
                    Esc
                      Translator
              Style
                Esc
                  Translator
          Presentation
            Colour
              Esc
                Translator
          Queue
          RenderInterface
            ClearInterface
          Style
            Esc
              Translator
          Terminal
            Esc
              Translator
        Repository
          Storage
      Terminal
        Esc
          Translator
    Process
      CommandRepository
        Command
        Repository
          Storage
      Parser
        Compositor
          Composition
            InterfaceCollection
              InterfaceRepository
                Interface
                  ClearInterface
                  Coordinate
                    Esc
                      Translator
                    Terminal
                      Esc
                        Translator
                  LineCollection
                    Collection
                    Line
                      Presentation
                        Colour
                          Esc
                            Translator
                      StreamCollection
                        Collection
                        Stream
                          Presentation
                            Colour
                              Esc
                                Translator
                          Style
                            Esc
                              Translator
                      Style
                        Esc
                          Translator
                  Presentation
                    Colour
                      Esc
                        Translator
                  Queue
                  RenderInterface
                    ClearInterface
                  Style
                    Esc
                      Translator
                  Terminal
                    Esc
                      Translator
                Repository
                  Storage
        HashParser
          TextAdaptor
        JSONParser
      Queue
    Terminal
      Esc
        Translator
  Configuration