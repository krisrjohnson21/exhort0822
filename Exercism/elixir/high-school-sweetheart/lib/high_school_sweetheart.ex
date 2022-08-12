defmodule HighSchoolSweetheart do
  def first_letter(name) do
    String.trim(name) |> String.first()
  end

  def initial(name) do
    String.upcase(first_letter(name))<> "."
  end

  def initials(full_name) do
    initials = String.split(full_name)
    initial(List.first(initials))<>" "<>initial(List.last(initials))
  end

  def pair(full_name1, full_name2) do
    first = initials(full_name1)
    second = initials(full_name2)

                   """
                    ******       ******
                  **      **   **      **
                **         ** **         **
               **            *            **
               **                         **
               **     #{first}  +  #{second}     **
                **                       **
                  **                   **
                    **               **
                      **           **
                        **       **
                          **   **
                            ***
                             *
               """
  end
end
