#!/bin/bash
# Sample script to be used to run the project on a benchmark.

# Print utility
print_msg() {
  local label="$1"; shift
  local msg="$*"
  local color="${COLOR:-36}"

  printf "\033[1;%sm◉ %s:\033[0m %s\n" "$color" "$label" "$msg"
}

print_banner() {
  local title="$*"
  printf "\033[1;35m╭─────────────────────────────────────────────────────╮\033[0m\n"
  printf "\033[1;35m│ %-44s │\033[0m\n" "$title"
  printf "\033[1;35m╰─────────────────────────────────────────────────────╯\033[0m\n"
}

# Set the paths according to your installation. All paths must be full paths.

# Installed path of Java 8 JDK
java_install_path=`realpath /Users/manas/Programs/Soot-playground/jdk-binaries/jdk1.8.0_471.jdk/Contents/Home`

# contain individual Benchmarks 
Benchmarks_base_path=`realpath ../Benchmarks/`

# The soot jar to be used.
soot_path=`realpath ../soot/sootclasses-trunk-jar-with-dependencies.jar`

# Path to code repository
code_path=`realpath ..`
code_run="${code_path}/src/"

java_compiler="${java_install_path}/bin/javac"
java_vm="${java_install_path}/bin/java"

clean () {
    print_msg "1. Clearing folders [/out]......" 
    rm -rf out 2>/dev/null
}
if [[ $1 == "olddacapo" ]]; then
    print_banner "Running Soot for \"Dacapo-9.12-MR1 \" Benchmark-Suite"
    benchmark_path="${Benchmarks_base_path}/dacapo"
    # Generate out folder for dacapo
    cd ${benchmark_path}
    clean
    print_msg "Generating benchmark/out folder for $2 ......"
    $java_vm -javaagent:${benchmark_path}/poa-trunk.jar -jar ${benchmark_path}/dacapo-9.12-MR1-bach.jar $2 
    print_msg "Generated !!!"
    cd ${code_path}/scripts
    main_class="Harness"
elif [[ $1 == "newdacapo" ]]; then
    print_banner "Running Soot for \"Dacapo-23.11-MR1\" Benchmark-Suite"
    benchmark_path="${Benchmarks_base_path}/dacapo-chopin/dacapo-23.11-chopin"
    mkdir -p "${output_base_path}/dacapo-chopin"
    main_class="Harness"
elif [[ $1 == "jbb" ]]; then
    print_banner "Running Soot for \"Specjbb-2005\" Benchmark-Suite"
    benchmark_path="${Benchmarks_base_path}/spec-jbb/"
    mkdir -p "${output_base_path}/spec-jbb/"
    main_class="spec.jbb.JBBmain"
elif [[ $1 == "jvm" ]]; then
    print_banner "Running Soot for \"SpecJVM-2008\" Benchmark-Suite"
    benchmark_path="${Benchmarks_base_path}/spec-jvm/"
    mkdir -p "${output_base_path}/spec-jvm/"
    main_class="spec.harness.Launch"
elif [[ $1 == "ren" ]]; then
    print_banner "Running Soot for \"Rennaiance\" Benchmark-Suite"
    benchmark_path="${Benchmarks_base_path}/renaissance/"
    mkdir -p "${output_base_path}/renaissance/"
    main_class="org.renaissance.core.Launcher"
else
    echo benchmark-suite not recognised
    exit 0
fi

find  ${code_path}/src -type f -name '*.class' -delete
print_msg "2. Compiling Code......"
$java_compiler -cp $soot_path:${code_path}/src ${code_path}/src/main/Main.java
print_msg "3. Compiled !! Starting Analysis......"
$java_vm -Xmx10g -Xss2m -classpath $soot_path:$code_run main.Main $java_install_path true $benchmark_path $main_class $1 $2
