  <!-- Content Header (Page header) -->
  <section class="content-header">
    <h1>
      Data Tables
      <small>advanced tables</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
      <li><a href="#">Tables</a></li>
      <li class="active">Data tables</li>
    </ol>
  </section>

  <!-- Main content -->
  <section class="content">
    <!-- ADD USERR -->
    <button type="button" class="btn btn-default pull-right" data-toggle="modal" data-target="#modal-default" onclick="return send_data_add();">Add User
    </button>

    <div class="row">
      <div class="col-xs-12">
        <div class="box">
          <div class="box-header">
            <h3 class="box-title">Data Table With Full Features</h3>
          </div>
          <!-- /.box-header -->
          <div class="box-body">
            <table id="example1" class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th>No.</th>
                  <th>User Name</th>
                  <th>Password</th>
                  <th>Type</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody id="listUser">
                <?php $no=1 ?> {% for user in data_user %}
                <tr id="data_{{user.id}}">
                  <td><?php echo $no++; ?></td>
                  <td>{{user.username}}</td>
                  <td>{{user.password}}</td>
                  <td>{{user.type}}</td>
                  <td>
                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#modal-default" onclick="return send_data_edit('{{user.id}}');" >Edit</button>

                    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#modal-delete" onclick="return send_data_delete('{{user.id}}');">Delete</button>
                  </td>
                </tr>
                {% endfor %}
              </tbody>
            </table>
          </div>
          <!-- /.box-body -->
        </div>
        <!-- /.box -->
      </div>
      <!-- /.col -->
    </div>
    <!-- /.row -->
  </section>
  <!-- /.content -->
  <div class="modal fade" id="modal-default">
    <div class="modal-dialog">
      <div class="modal-content">
        <form class="addUser" action="user/addUser" method="POST">
          <div class="modal-header">
            <button type="button" class="close close-modal" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title">Tambah User</h4>
            </div>
            <div class="modal-body">

              <div class="input-group-id">
                <input type="hidden" name="id" class="form-control id" id="id">
              </div>
              <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                <input type="Text" class="form-control" placeholder="Username" name="username">
              </div>
              <br>
              <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-key"></i></span>
                <input type="password" class="form-control" placeholder="Password" name="password">
              </div>
              <br>
              <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-book"></i></span>
                <input type="text" class="form-control" placeholder="Type" name="type">
              </div>
            </div>
            <br>
            <div class="modal-footer">
              <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary btnAction" onclick="return addUser();">Add User</button>
            </div>
          </form>
        </div>
        <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
    </div>

  <div class="modal modal-danger fade" id="modal-delete">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">x</span></button>
                <h4 class="modal-title">Delete User</h4>
              </div>
            <form class="deleteUser" action="user/deleteUser" method="POST">
              <div class="modal-body">
                <div class="input-group-id">
                  <input type="hidden" name="id" class="form-control id" id="id">
                </div>
                <p>Hapus User ini?</p>
              </div>
            </form>
              <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-outline" onclick="return deleteUser();">Delete User</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>

  <script>

  function send_data_add() {
    $('.modal-title').text('Tambah User');
    $('.input-group-id').remove();
    $('.btnAction').attr('class',"btn btn-primary btnAction");
    $('.btnAction').text('Add User');
  }

  function addUser() {

    $.ajax({
      method: "POST",
      dataType: "json",
      url: "{{url('user/addUser')}}", //tujuan data  func:addUser
      data: $('form.addUser').serialize(), //seri.. ubah jd format serialize
      success: function(res)/*result hasil bisa apa saja*/{
        new PNotify({
          title: res.title,
          text: res.text,
          type: res.type,
          addclass:"stack-bottomright"
        });
        $('.close-modal').click();
      }
    })
  }

  function send_data_edit(id) {
    $('.modal-title').text('Edit User'+' '+id); //select class -ganti text jquery
    $('.id').remove();
    $('.input-group-id').append('<input type="hidden" name="id" class="form-control id" id="id">');
    $('.btnAction').attr('onclick',"return editUser();");
    $('.btnAction').attr('class',"btn btn-warning btnAction");
    $('.btnAction').text('Edit User');

    // value edit tampilan dari form
    var username = $('#data_'+ id + '>td').eq(1).html()
    var password = $('#data_'+ id + '>td').eq(2).html()
    var type = $('#data_'+ id + '>td').eq(3).html()

    $('input[name=id]').val(id);
    $('input[name=username]').val(username);
    $('input[name=password]').val(password);
    $('input[name=type]').val(type);
  }

  function editUser() {
    $.ajax({
      method: "POST",
      dataType: "json",
      url: "{{url('user/editUser')}}", //tujuan data  func:addUser
      data: $('form.addUser').serialize(), //seri.. ubah jd format serialize
      success: function(res)/*result hasil bisa apa saja*/{
        new PNotify({
          title: res.title,
          text: res.text,
          type: res.type,
          addclass:"stack-bottomright"
        });
        $('.close-modal').click();

      }
    })
  }

  function send_data_delete(id) {
    $('input[name=id]').val(id);
    $('.modal-title').text('Delete User' + ' ' +id);

    $('.btnAction').attr('onclick',"return deleteUser();");
    $('.btnAction').attr('class',"btn btn-outline btnAction");
    $('.btnAction').text('Delete User');

  }

  function deleteUser() {
    $.ajax({
      method: "POST",
      dataType: "json",
      url: "{{url('user/deleteUser')}}", //tujuan data  func:addUser
      data: $('form.deleteUser').serialize(), //seri.. ubah jd format serialize
      success: function(res)/*result hasil bisa apa saja*/{
        new PNotify({
          title: res.title,
          text: res.text,
          type: res.type,
          addclass:"stack-bottomright"
        });
        $('.close-modal').click();

      }
    })
  }

  function listUser(){
        $.ajax({
            method:"GET",
            url: "{{ url('user/listUser')}}",
            dataType: "html",
            success: function(res) {
                $('#listUser').html(res);
            }
        });
    }

  </script>